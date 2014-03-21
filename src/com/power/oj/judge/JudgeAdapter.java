package com.power.oj.judge;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentLinkedQueue;

import jodd.io.FileNameUtil;
import jodd.io.FileUtil;
import jodd.util.StringUtil;

import com.jfinal.log.Logger;
import com.power.oj.contest.ContestService;
import com.power.oj.contest.model.ContestSolutionModel;
import com.power.oj.core.OjConfig;
import com.power.oj.core.bean.ResultType;
import com.power.oj.core.model.ProgramLanguageModel;
import com.power.oj.problem.ProblemModel;
import com.power.oj.problem.ProblemService;
import com.power.oj.solution.SolutionModel;
import com.power.oj.user.UserService;

public abstract class JudgeAdapter implements Runnable
{
  public static final String DATA_EXT_IN = ".in";
  public static final String DATA_EXT_OUT = ".out";
  public static final String sourceFileName = "Main";
  
  protected final Logger log = Logger.getLogger(getClass());
  protected static final String workPath;
  protected static final ContestService contestService = ContestService.me();
  protected static final UserService userService = UserService.me();
  protected static final ProblemService problemService = ProblemService.me();
  protected static ConcurrentLinkedQueue<SolutionModel> judgeList = new ConcurrentLinkedQueue<SolutionModel>();
  protected SolutionModel solutionModel;
  protected ProblemModel problemModel;
  protected ProgramLanguageModel language;
  protected String workDirPath;
  
  protected List<String> inFiles = new ArrayList<String>();
  protected List<String> outFiles = new ArrayList<String>();
  
  static
  {
    // TODO move to OjConfig
    workPath = new StringBuilder(2).append(FileNameUtil.normalizeNoEndSeparator(OjConfig.get("workPath"))).append(File.separator).toString();
  }
  
  public JudgeAdapter()
  {
    super();
  }
  
  protected abstract boolean Compile() throws IOException;
  
  protected abstract boolean RunProcess() throws IOException, InterruptedException;

  public void run()
  {
    log.info("JudgeAdapter run()");
    while (!judgeList.isEmpty())
    {
      log.info("Judge threads: " + judgeList.size());
      solutionModel = judgeList.poll();
      synchronized (JudgeAdapter.class)
      {
        try
        {
          prepare();
          if (Compile())
          {
            RunProcess();
          }
          else
          {
            log.warn("Compile failed.");
          }
        } catch (Exception e)
        {
          updateSystemError(e.getLocalizedMessage());
          
          if (OjConfig.getDevMode())
            e.printStackTrace();
          log.error(e.getLocalizedMessage());
        }
      }
    }
  }
  
  protected void prepare() throws IOException
  {
    language = (ProgramLanguageModel) OjConfig.language_type.get(solutionModel.getLanguage());
    problemModel = problemService.findProblem(solutionModel.getPid());
    
    if (OjConfig.getBoolean("deleteTmpFile"))
    {
      File prevWorkDir = new File(new StringBuilder(2).append(workPath).append(solutionModel.getSid() - 2).toString());
      if (prevWorkDir.isDirectory())
      {
        FileUtil.deleteDir(prevWorkDir);
        log.info("Delete previous work directory " + prevWorkDir.getAbsolutePath());
      }
    }
    
    File workDir = new File(new StringBuilder(2).append(workPath).append(solutionModel.getSid()).toString());
    FileUtil.mkdirs(workDir);
    workDirPath = workDir.getAbsolutePath();
    log.info("mkdirs workDir: " + workDirPath);
  }

  protected String getCompileCmd(String compileCmd, String path, String name, String ext)
  {
    path = new StringBuilder(2).append(path).append(File.separator).toString();
    compileCmd = StringUtil.replace(compileCmd, "%PATH%", path);
    compileCmd = StringUtil.replace(compileCmd, "%NAME%", name);
    compileCmd = StringUtil.replace(compileCmd, "%EXT%", ext);
    compileCmd = new StringBuilder(2).append(compileCmd).append("\n").toString();

    return compileCmd;
  }
  
  protected int getDataFiles() throws IOException
  {
    File dataDir = new File(new StringBuilder(3).append(OjConfig.get("dataPath")).append(File.separator).append(solutionModel.getPid()).toString());
    if (!dataDir.isDirectory())
    {
      throw new IOException("Data files does not exist.");
    }
    log.info("dataDir: " + dataDir.getAbsolutePath());
    
    inFiles = new ArrayList<String>();
    outFiles = new ArrayList<String>();
    File[] arrayOfFile = dataDir.listFiles();

    for (int i = 0; i < arrayOfFile.length; i++)
    {
      File in_file = arrayOfFile[i];
      if (!in_file.getName().toLowerCase().endsWith(DATA_EXT_IN))
        continue;
      File out_file = new File(new StringBuilder().append(dataDir.getAbsolutePath()).append(File.separator)
          .append(in_file.getName().substring(0, in_file.getName().length() - DATA_EXT_IN.length())).append(DATA_EXT_OUT).toString());
      if (!out_file.isFile())
      {
        log.warn("Output file for input file does not exist: " + in_file.getAbsolutePath());
        continue;
      }
      inFiles.add(in_file.getAbsolutePath());
      outFiles.add(out_file.getAbsolutePath());
    }
    
    return inFiles.size();
  }
  
  protected boolean updateCompileError(String error)
  {
    solutionModel.setResult(ResultType.CE).setError(error);
    
    Integer cid = solutionModel.getCid();
    if (cid != null && cid > 0)
    {
      log.info("updateCompileError");
      ContestSolutionModel contestSolution = new ContestSolutionModel(solutionModel);
      return contestSolution.update();
    }
    return solutionModel.update();
  }

  protected boolean updateSystemError(String error)
  {
    solutionModel.setResult(ResultType.SE).setSystemError(error);

    Integer cid = solutionModel.getCid();
    log.info(solutionModel.toString());
    if (cid != null && cid > 0)
    {
      log.info("updateSystemError");
      ContestSolutionModel contestSolution = new ContestSolutionModel(solutionModel);
      return contestSolution.update();
    }
    return solutionModel.update();
  }
  
  protected boolean updateResult(int result, int time, int memory)
  {
    solutionModel.setResult(result).setTime(time).setMemory(memory);

    Integer cid = solutionModel.getCid();
    if (cid != null && cid > 0)
    {
      log.info("updateResult");
      ContestSolutionModel contestSolution = new ContestSolutionModel(solutionModel);
      return contestSolution.update();
    }
    return solutionModel.update();
  }
  
  protected boolean updateUser()
  {
    if (solutionModel.getResult() != ResultType.AC)
    {
      return false;
    }
    
    return userService.incAccepted(solutionModel.getUid());
  }

  protected boolean updateProblem()
  {
    if (solutionModel.getResult() != ResultType.AC)
    {
      return false;
    }

    return problemService.incAccepted(solutionModel);
  }

  protected boolean updateContest()
  {
    Integer cid = solutionModel.getCid();
    if (cid != null && cid > 0)
    {
      contestService.updateBoard(solutionModel);
      return true;
    }
    return false;
  }

  public static void addSolution(SolutionModel solutionModel)
  {
    judgeList.add(solutionModel);
  }
  
  public static int size()
  {
    return judgeList.size();
  }
  
}
