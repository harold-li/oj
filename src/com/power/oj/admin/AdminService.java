package com.power.oj.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.jfinal.kit.PathKit;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.power.oj.core.AppConfig;
import com.power.oj.core.OjConfig;
import com.power.oj.core.bean.DataFile;
import com.power.oj.core.bean.FpsProblem;
import com.power.oj.core.model.VariableModel;
import com.power.oj.core.service.FpsService;
import com.power.oj.problem.ProblemModel;
import com.power.oj.user.UserModel;
import com.power.oj.user.UserService;
import com.power.oj.util.XmlUtil;

import jodd.io.FileUtil;
import jodd.util.BCrypt;
import jodd.util.SystemUtil;

public final class AdminService
{
  private static final int MAX_EDIT_DATA_SIZE = 2 * 1024 * 1024;
  private static final Logger log = Logger.getLogger(AdminService.class);
  private static final AdminService me = new AdminService();
  
  private AdminService() {}
  
  public static AdminService me()
  {
    return me;
  }
  
  public Map<String, Object> getSystemInfo()
  {
    Map<String, Object> systemInfo = new HashMap<String, Object>();
    Properties sysProperty = System.getProperties();

    systemInfo.put("JREName", sysProperty.getProperty("java.runtime.name"));
    systemInfo.put("JREVersion", sysProperty.getProperty("java.runtime.version"));
    systemInfo.put("javaHome", sysProperty.getProperty("java.home"));
    systemInfo.put("javaVendor", sysProperty.getProperty("java.vendor"));
    systemInfo.put("javaVersion", SystemUtil.getJavaVersion());
    systemInfo.put("OSName", SystemUtil.getOsName());
    systemInfo.put("OSVersion", SystemUtil.getOsVersion());
    systemInfo.put("OSArch", sysProperty.getProperty("os.arch"));
    systemInfo.put("timezone", sysProperty.getProperty("user.timezone"));
    systemInfo.put("fileSeparator", sysProperty.getProperty("file.separator"));
    systemInfo.put("tempDir", SystemUtil.getTempDir());
    systemInfo.put("workDir", SystemUtil.getUserDir());
    systemInfo.put("userHome", SystemUtil.getUserHome());
    
    systemInfo.put("mysql", Db.queryStr("select version() as v"));
    
    return systemInfo;
  }
  
  public Map<String, Object> getOjInfo()
  {
    Map<String, Object> ojInfo = new HashMap<String, Object>();
    String rootPath = PathKit.getWebRootPath();
    
    ojInfo.put("webRootPath", rootPath);
    ojInfo.put("baseViewPath", AppConfig.getBaseViewPath());
    ojInfo.put("devMode", OjConfig.isDevMode());
    ojInfo.put("siteTitle", OjConfig.siteTitle);
    ojInfo.put("userAvatarPath", OjConfig.userAvatarPath.replace(rootPath, ""));
    ojInfo.put("problemImagePath", OjConfig.problemImagePath.replace(rootPath, ""));
    ojInfo.put("uploadPath", OjConfig.uploadPath.replace(rootPath, ""));
    ojInfo.put("downloadPath", OjConfig.downloadPath.replace(rootPath, ""));
    
    ojInfo.put("workPath", OjConfig.getString("workPath"));
    ojInfo.put("dataPath", OjConfig.getString("dataPath"));
    ojInfo.put("runShell", OjConfig.getString("runShell"));
    ojInfo.put("compilerShell", OjConfig.getString("compileShell"));
    ojInfo.put("debugFile", OjConfig.getString("debugFile"));
    ojInfo.put("errorFile", OjConfig.getString("errorFile"));
    
    return ojInfo;
  }
  
  public void reloadConfig(String type)
  {
    switch(type)
    {
      case "var":
        OjConfig.loadVariable();break;
      case "lang":
        OjConfig.loadLanguage();break;
      case "level":
        OjConfig.loadLevel();break;
      default:
        OjConfig.loadConfig();
    }
  }
  
  public int updateConfig(String name, String value, String type)
  {
    VariableModel variable = OjConfig.get(name);
    
    if (variable == null)
    {
      return -1;
    }
    
    switch (type)
    {
      case "string":
        variable.setStringValue(value);break;
      case "boolean":
        variable.setBooleanValue(Boolean.valueOf(value));break;
      case "int":
        variable.setIntValue(Integer.parseInt(value));break;
      case "text":
        variable.setTextValue(value);break;
      default:
        return -2;
    }
    variable.setType(type);
    
    return variable.update() ? 0 : 1;
  }
  
  public boolean setUserPassword(String name, String password)
  {
    UserModel user = UserService.me().getUserByName(name);
    if (user == null)
    {
      return false;
    }
    password = BCrypt.hashpw(password, BCrypt.gensalt());
    
    user.setPassword(password).setMtime(OjConfig.timeStamp);
    return user.update();
  }
  
  public Page<Record> getLoginlog(int pageNumber, int pageSize)
  {
    return Db.paginate(pageNumber, pageSize, 
        "SELECT *", "FROM loginlog ORDER BY ctime DESC");
  }
  
  public List<DataFile> getDataFiles(Integer pid)
  {
    List<DataFile> dataFiles = new ArrayList<DataFile>();
    File dataDir = new File(new StringBuilder(3).append(OjConfig.getString("dataPath")).append(File.separator).append(pid).toString());
    
    if (!dataDir.isDirectory())
    {
      return dataFiles;
    }
    
    File[] arrayOfFile = dataDir.listFiles();
    if (arrayOfFile.length > 1)
    {
      Arrays.sort(arrayOfFile);
    }
    
    for (int i = 0; i < arrayOfFile.length; i++)
    {
      DataFile dataFile = new DataFile(pid, arrayOfFile[i]);
      dataFiles.add(dataFile);
    }
    
    return dataFiles;
  }
  
  public String uploadData(Integer pid, String filename, File srcFile) throws IOException
  {
    File destFile = new DataFile(pid, filename).getFile();
    
    FileUtil.moveFile(srcFile, destFile);
    log.debug(destFile.getAbsolutePath());
    
    return destFile.getName();
  }
  
  public File downloadData(Integer pid, String filename)
  {
    File file = new DataFile(pid, filename).getFile();
    
    if (file.exists())
    {
      return file;
    }
    
    return null;
  }

  public String viewData(Integer pid, String filename)
  {
    DataFile dataFile = new DataFile(pid, filename);
    
    if (dataFile.exists())
    {
      try
      {
        String content = dataFile.readString();
        if (content == null)
        {
          return "unsupport file type.";
        }
        return content;
      } catch (IOException e)
      {
        if (OjConfig.isDevMode())
          e.printStackTrace();
        log.error(e.getLocalizedMessage());
        
        return "cannot read file.";
      }
    }
    
    return "file not exists.";
  }
  
  public String editData(Integer pid, String filename)
  {
    DataFile dataFile = new DataFile(pid, filename);
    
    if (dataFile.exists())
    {
      try
      {
        String content = dataFile.readString();
        if (content != null && content.length() >= MAX_EDIT_DATA_SIZE)
        {
          content = null;
        }
        return content;
      } catch (IOException e)
      {
        if (OjConfig.isDevMode())
          e.printStackTrace();
        log.error(e.getLocalizedMessage());
        
        return null;
      }
    }
    
    return null;
  }
  
  public boolean updateData(Integer pid, String originalName, String filename, String content)
  {
    DataFile srcFile = new DataFile(pid, originalName);

    if (srcFile.exists())
    {
      try
      {
        srcFile.writeString(content);
        if (!originalName.equals(filename))
        {
          DataFile destFile = new DataFile(pid, filename);
          destFile.touch();
          FileUtil.move(srcFile.getFile(), destFile.getFile());
        }
      } catch (IOException e)
      {
        if (OjConfig.isDevMode())
          e.printStackTrace();
        log.error(e.getLocalizedMessage());
        
        return false;
      }
    }
    else
    {
      return false;
    }
    return true;
  }

  public boolean deleteData(Integer pid, String filename)
  {
    File srcFile = new DataFile(pid, filename).getFile();
    File destFile = new File(OjConfig.uploadPath + File.separator + filename);
    
    try
    {
      FileUtil.moveFile(srcFile, destFile);
    } catch (IOException e)
    {
      if (OjConfig.isDevMode())
        e.printStackTrace();
      log.error(e.getLocalizedMessage());
      
      return false;
    }
    
    return true;
  }
  
  public List<FpsProblem> importProblems(File file, Integer outputLimit, Boolean status)
  {
    Document document = null;
    List<FpsProblem> problemList = new ArrayList<FpsProblem>();
    
    try
    {
      document = XmlUtil.readDocument(file);
    } catch (DocumentException e)
    {
      if (OjConfig.isDevMode())
      {
        log.warn("read xml failed!", e);
      }
      log.error(e.getLocalizedMessage());
      
      return problemList;
    }
    
    try
    {
      FileUtil.mkdirs(OjConfig.problemImagePath);
    } catch (IOException e)
    {
      if (OjConfig.isDevMode())
      {
        log.warn("mkdir for problem image failed!", e);
      }
      log.error(e.getLocalizedMessage());
      // why continue?
    }

    FpsService fpsService = new FpsService();
    Element root = document.getRootElement();
    for (Iterator<?> i = root.elementIterator("item"); i.hasNext();)
    {
      Element ele = (Element) i.next();
      FpsProblem problem = new FpsProblem(outputLimit * 1024, status);
      fpsService.setFpsProblem(problem);
      fpsService.itemToProblem(ele);
      problemList.add(problem);
    }

    return problemList;
  }
  
  public File exportProblems(String problems, Boolean status, Boolean replace)
  {
    String[] pidStr = problems.split(",");
    Document document = DocumentHelper.createDocument();
    Element rootElement = XmlUtil.createXmlRootElement(document);
    FpsService fpsService = new FpsService();
    
    for (String pidPar : pidStr)
    {
      String pids[] = pidPar.split("-");
      if (pids.length == 1)
      {
        try
        {
          Integer pid = Integer.parseInt(pids[0]);
          ProblemModel problemModel = null;
          if (status)
          {
            problemModel = ProblemModel.dao.
              findFirst("SELECT * FROM problem WHERE pid=? AND status=1", pid);
          }
          else
          {
            problemModel = ProblemModel.dao.findFirst("SELECT * FROM problem WHERE pid=?", pid);
          }
          Element item = rootElement.addElement("item");
          
          item.addAttribute("pid", String.valueOf(problemModel.getPid()));
          FpsProblem problem = new FpsProblem(problemModel);
          fpsService.setFpsProblem(problem);
          fpsService.problemToItem(item, replace);
        } catch (NumberFormatException e)
        {
          if (OjConfig.isDevMode())
          {
            log.warn("incorrect problem id to export!", e);
          }
          log.error(e.getLocalizedMessage());
          
          return null;
        }
      }
      else if (pids.length == 2)
      {
        Integer start = 1;
        Integer end = 0;
        try
        {
          start = Integer.parseInt(pids[0]);
          end = Integer.parseInt(pids[1]);
        } catch (NumberFormatException e)
        {
          if (OjConfig.isDevMode())
          {
            log.warn("incorrect problem id to export!", e);
          }
          log.error(e.getLocalizedMessage());
          
          return null;
        }
        
        if (start <= end)
        {
          List<ProblemModel> problemList = null;
          if (status)
          {
            problemList = ProblemModel.dao.
              find("SELECT * FROM problem WHERE pid>=? AND pid<=? AND status=1", start, end);
          }
          else
          {
            problemList = ProblemModel.dao.
                find("SELECT * FROM problem WHERE pid>=? AND pid<=?", start, end);
          }
          for (ProblemModel problemModel : problemList)
          {
            Element item = rootElement.addElement("item");
            item.addAttribute("pid", String.valueOf(problemModel.getPid()));
            FpsProblem problem = new FpsProblem(problemModel);
            fpsService.setFpsProblem(problem);
            fpsService.problemToItem(item, replace);
          }
        }
      }
    }

    String fileName = "PowerOJ-" + problems.replace(",", "_") + ".xml";
    return XmlUtil.exportXmlFile(document, fileName);
  }
  
  public File exportProblems(Integer start, Integer end, Boolean status, Boolean replace)
  {
    if (start > end)
    {
      return null;
    }
    
    Document document = DocumentHelper.createDocument();
    Element rootElement = XmlUtil.createXmlRootElement(document);
    FpsService fpsService = new FpsService();
    
    List<ProblemModel> problemList = ProblemModel.dao.
        find("SELECT * FROM problem WHERE pid>=? AND pid<=? AND status=?", start, end, status ? 1 : 0);
    for (ProblemModel problemModel : problemList)
    {
      Element item = rootElement.addElement("item");
      item.addAttribute("pid", String.valueOf(problemModel.getPid()));
      FpsProblem problem = new FpsProblem(problemModel);
      fpsService.setFpsProblem(problem);
      fpsService.problemToItem(item, replace);
    }

    String fileName = "PowerOJ-" + start + "-" + end + ".xml";
    return XmlUtil.exportXmlFile(document, fileName);
  }
  
}
