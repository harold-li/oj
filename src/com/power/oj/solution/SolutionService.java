package com.power.oj.solution;

import java.util.ArrayList;
import java.util.List;

import jodd.util.StringUtil;

import com.jfinal.plugin.activerecord.Page;
import com.power.oj.contest.ContestService;
import com.power.oj.contest.model.ContestModel;
import com.power.oj.contest.model.ContestSolutionModel;
import com.power.oj.core.OjConfig;
import com.power.oj.core.bean.ResultType;
import com.power.oj.judge.JudgeService;
import com.power.oj.problem.ProblemModel;
import com.power.oj.problem.ProblemService;
import com.power.oj.user.UserService;

public final class SolutionService
{
  private static final SolutionModel dao = SolutionModel.dao;
  private static final SolutionService me = new SolutionService();

  private static final JudgeService judgeService = JudgeService.me();
  private static final UserService userService = UserService.me();
  private static final ProblemService problemService = ProblemService.me();
  
  private SolutionService() {}
  public static SolutionService me()
  {
    return me;
  }

  public Page<SolutionModel> getPage(int pageNumber, int pageSize, int result, int language, int pid, String userName)
  {
    String sql = "SELECT sid,s.uid,pid,cid,num,result,time,memory,s.language,codeLen,FROM_UNIXTIME(s.ctime, '%Y-%m-%d %H:%i:%s') AS ctime_t,u.name";
    StringBuilder sb = new StringBuilder("FROM solution s LEFT JOIN user u ON u.uid=s.uid WHERE cid=0 ");

    List<Object> paras = new ArrayList<Object>();
    if (result > -1)
    {
      if (result == 999)
      {
        sb.append(" AND result!=?");
        paras.add(ResultType.AC);
      }
      else
      {
        sb.append(" AND result=?");
        paras.add(result);
      }
    }
    if (language > 0)
    {
      sb.append(" AND s.language=?");
      paras.add(language);
    }
    if (pid > 0)
    {
      sb.append(" AND pid=? AND cid=0");
      paras.add(pid);
    }
    if (StringUtil.isNotBlank(userName))
    {
      sb.append(" AND name=?");
      paras.add(userName);
    }

    if (!userService.isAdmin())
    {
      sb.append(" AND s.status=1");
    }
    sb.append(" ORDER BY sid DESC");
    Page<SolutionModel> solutionList = dao.paginate(pageNumber, pageSize, sql, sb.toString(), paras.toArray());

    for (SolutionModel solution : solutionList.getList())
    {
      solution.put("languageName", (OjConfig.languageType.get(solution.getLanguage())).get("name"));

      ResultType resultType = OjConfig.resultType.get(solution.getResult());
      solution.put("resultName", resultType.getName());
      solution.put("resultLongName", resultType.getLongName());

      /*if (solution.getNum() != null && solution.getNum() > -1)
      {
        solution.put("alpha", (char) (solution.getNum() + 'A'));
      }*/
    }

    return solutionList;
  }

  public SolutionModel findSolution(Integer sid)
  {
    return dao.findFirst("SELECT * FROM solution WHERE sid=? AND status=1 LIMIT 1", sid);
  }

  public SolutionModel getSolutionResult(Integer sid)
  {
    SolutionModel solutionModel = dao.findFirst("SELECT sid,time,memory,result FROM solution WHERE sid=? AND status=1 LIMIT 1", sid);
    solutionModel.set("result", OjConfig.resultType.get(solutionModel.getResult()));
    return solutionModel;
  }
  
  public ContestSolutionModel findContestSolution(Integer sid)
  {
    return ContestSolutionModel.dao.findFirst("SELECT * FROM contest_solution WHERE sid=? AND status=1 LIMIT 1", sid);
  }

  public ContestSolutionModel findContestSolution4Json(Integer sid)
  {
    return ContestSolutionModel.dao.findFirst("SELECT cid,codeLen,s.language,time,memory,num,result,source,s.uid,u.name FROM contest_solution s LEFT JOIN user u ON u.uid=s.uid WHERE sid=? AND s.status=1 LIMIT 1", sid);
  }

  public ContestSolutionModel getContestSolutionResult(Integer cid, Integer sid)
  {
    // TODO check permission
    ContestSolutionModel solutionModel = ContestSolutionModel.dao.
        findFirst("SELECT cid,sid,time,memory,result FROM contest_solution WHERE cid=? AND sid=? AND status=1 LIMIT 1", cid, sid);
    solutionModel.set("result", OjConfig.resultType.get(solutionModel.getResult()));
    return solutionModel;
  }
  
  public Page<ContestSolutionModel> getPageForContest(int pageNumber, int pageSize, int result, int language, int cid, int num, String userName)
  {
    String sql = "SELECT sid,s.uid,pid,cid,num,result,time,memory,s.language,codeLen,FROM_UNIXTIME(s.ctime, '%Y-%m-%d %H:%i:%s') AS ctime_t,u.name,u.nick";
    StringBuilder sb = new StringBuilder("FROM contest_solution s LEFT JOIN user u ON u.uid=s.uid WHERE cid=?");
    List<Object> paras = new ArrayList<Object>();
    paras.add(cid);
    
    if (result > -1)
    {
      if (result == 999)
      {
        sb.append(" AND result!=?");
        paras.add(ResultType.AC);
      }
      else
      {
        sb.append(" AND result=?");
        paras.add(result);
      }
    }
    if (language > 0)
    {
      sb.append(" AND s.language=?");
      paras.add(language);
    }
    if (num > -1)
    {
      sb.append(" AND num=?");
      paras.add(num);
    }
    if (StringUtil.isNotBlank(userName))
    {
      sb.append(" AND name=?");
      paras.add(userName);
    }

    if (userService.isAdmin())
    {
      sb.append(" AND s.status=1");
    }
    sb.append(" ORDER BY sid DESC");
    Page<ContestSolutionModel> solutionList = ContestSolutionModel.dao.paginate(pageNumber, pageSize, sql, sb.toString(), paras.toArray());

    for (ContestSolutionModel solution : solutionList.getList())
    {
      solution.put("languageName", OjConfig.languageName.get(solution.getLanguage()));

      ResultType resultType = OjConfig.resultType.get(solution.getResult());
      solution.put("resultName", resultType.getName());
      solution.put("resultLongName", resultType.getLongName());
      solution.put("alpha", (char) (solution.getNum() + 'A'));
    }

    return solutionList;
  }

  public Page<SolutionModel> getPage(int pageNumber, int pageSize, Integer result, Integer language, Integer uid)
  {
    String sql = "SELECT sid,s.uid,s.pid,cid,num,result,time,memory,s.language,codeLen,s.ctime,p.title";
    StringBuilder sb = new StringBuilder("FROM solution s LEFT JOIN problem p ON p.pid=s.pid WHERE 1=1");

    List<Object> paras = new ArrayList<Object>();
    if (result > -1)
    {
      sb.append(" AND s.result=?");
      paras.add(result);
    }
    if (language > 0)
    {
      sb.append(" AND s.language=?");
      paras.add(language);
    }
    
    sb.append(" AND s.uid=?");
    paras.add(uid);

    if (!userService.isAdmin())
    {
      sb.append(" AND s.status=1");
    }

    sb.append(" ORDER BY sid DESC");
    Page<SolutionModel> solutionList = dao.paginate(pageNumber, pageSize, sql, sb.toString(), paras.toArray());

    for (SolutionModel solution : solutionList.getList())
    {
      solution.put("languageName", OjConfig.languageName.get(solution.getLanguage()));

      ResultType resultType = OjConfig.resultType.get(solution.getResult());
      solution.put("resultName", resultType.getName());
      solution.put("resultLongName", resultType.getLongName());
    }

    return solutionList;
  }

  public Page<SolutionModel> getProblemStatusPage(int pageNumber, int pageSize, Integer language, Integer pid)
  {
    // TODO check user permission for view source code
    String sql = "SELECT sid,s.uid,u.name,pid,result,time,memory,s.language,codeLen,s.ctime,l.name AS language";
    StringBuilder sb = new StringBuilder("FROM solution s LEFT JOIN user u ON u.uid=s.uid LEFT JOIN program_language l ON l.id=s.language WHERE result=?");

    List<Object> paras = new ArrayList<Object>();
    paras.add(ResultType.AC);
    
    if (language != null && language > 0)
    {
      sb.append(" AND s.language=?");
      paras.add(language);
    }

    sb.append(" AND pid=?");
    paras.add(pid);

    sb.append(" AND s.status=1 ORDER BY time,memory,codeLen,sid");
    Page<SolutionModel> solutionList = dao.paginate(pageNumber, pageSize, sql, sb.toString(), paras.toArray());

    return solutionList;
  }

  public Page<ContestSolutionModel> getProblemStatusPageForContest(int pageNumber, int pageSize, int language, int cid, int num)
  {
    String sql = null;
    ContestModel contestModel = ContestService.me().getContest(cid);
    if (!userService.isAdmin() && contestModel.getType() > ContestModel.TYPE_PASSWORD && 
        contestModel.getStartTime() <= OjConfig.timeStamp && contestModel.getEndTime() >= OjConfig.timeStamp)
    {
      sql = "SELECT sid,s.uid,u.name,pid,result,s.language,s.ctime,l.name AS language";
    }
    else
    {
      sql = "SELECT sid,s.uid,u.name,pid,result,time,memory,s.language,codeLen,s.ctime,l.name AS language";
    }
    StringBuilder sb = new StringBuilder("FROM contest_solution s LEFT JOIN user u ON u.uid=s.uid LEFT JOIN program_language l ON l.id=s.language WHERE result=?");

    List<Object> paras = new ArrayList<Object>();
    paras.add(ResultType.AC);
    
    if (language > 0)
    {
      sb.append(" AND s.language=?");
      paras.add(language);
    }

    sb.append(" AND cid=?");
    paras.add(cid);

    sb.append(" AND num=?");
    paras.add(num);

    sb.append(" AND s.status=1 ORDER BY time,memory,codeLen,sid");
    Page<ContestSolutionModel> solutionList = ContestSolutionModel.dao.paginate(pageNumber, pageSize, sql, sb.toString(), paras.toArray());

    return solutionList;
  }

  public List<ContestSolutionModel> getProblemStatusForContest(Integer cid, Integer num)
  {
    List<ContestSolutionModel> resultList = ContestSolutionModel.dao.find("SELECT result,COUNT(*) AS count FROM contest_solution WHERE cid=? AND num=? AND status=1 GROUP BY result", cid, num);
    
    for (ContestSolutionModel record : resultList)
    {
      ResultType resultType = OjConfig.resultType.get(record.getResult());
      record.put("longName", resultType.getLongName());
      record.put("name", resultType.getName());
    }
    
    return resultList;
  }
  
  public List<SolutionModel> getSolutionListForProblem(Integer pid)
  {
    List<SolutionModel> solutionList = dao.find("SELECT * FROM solution WHERE pid=? AND status=1 ORDER BY sid DESC", pid);
    return solutionList;
  }

  public List<SolutionModel> getWaitSolutionListForProblem(Integer pid)
  {
    List<SolutionModel> solutionList = dao.find("SELECT * FROM solution WHERE pid=? AND result=? AND status=1 ORDER BY sid DESC", pid, ResultType.WAIT);
    return solutionList;
  }

  public List<ContestSolutionModel> getSolutionListForContest(Integer cid)
  {
    List<ContestSolutionModel> solutionList = ContestSolutionModel.dao.find("SELECT * FROM contest_solution WHERE cid=? AND status=1 ORDER BY sid", cid);
    return solutionList;
  }

  public List<ContestSolutionModel> getSolutionListForContestProblem(Integer cid, Integer num)
  {
    List<ContestSolutionModel> solutionList = ContestSolutionModel.dao.find("SELECT * FROM contest_solution WHERE cid=? AND num=? AND status=1 ORDER BY sid", cid, num);
    return solutionList;
  }
  
  public int submitSolution(SolutionModel solutionModel)
  {
    Integer uid = userService.getCurrentUid();
    Integer pid = solutionModel.getPid();
    ProblemModel problemModel = problemService.findProblem(pid);
    
    if (problemModel == null)
    {
      return -1;
    }
    
    solutionModel.setUid(uid);
    
    if (solutionModel.addSolution())
    {
      judgeService.judge(solutionModel);
    } else
    {
      return -2;
    }

    return 0;
  }
  
}
