package com.power.oj.user;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;

import jodd.io.FileUtil;
import jodd.io.ZipUtil;
import jodd.util.BCrypt;
import jodd.util.HtmlEncoder;
import jodd.util.StringUtil;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.subject.Subject;

import com.jfinal.kit.PathKit;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;
import com.power.oj.api.oauth.WebLoginModel;
import com.power.oj.core.OjConfig;
import com.power.oj.core.OjConstants;
import com.power.oj.core.OjController;
import com.power.oj.core.bean.ResultType;
import com.power.oj.core.service.OjService;
import com.power.oj.core.service.SessionService;
import com.power.oj.image.ImageScaleImpl;
import com.power.oj.shiro.ShiroKit;
import com.power.oj.solution.SolutionModel;
import com.power.oj.util.FileKit;
import com.power.oj.util.Tool;

public final class UserService
{
  private static final Logger log = Logger.getLogger(UserService.class);
  private static final UserModel dao = UserModel.dao;
  private static final UserService me = new UserService();
  private static final OjService ojService = OjService.me();
  
  private UserService() {}
  
  public static UserService me()
  {
    return me;
  }
  
  /**
   * User login with name and password.
   * @param name user name.
   * @param password user password.
   * @param rememberMe ture if remember user.
   * @return true if login successfully, otherwise false.
   */
  public boolean login(String name, String password, boolean rememberMe)
  {
    Subject currentUser = ShiroKit.getSubject();
    UsernamePasswordToken token = new UsernamePasswordToken(name, password);
    token.setRememberMe(rememberMe);

    try
    {
      currentUser.logout();
      currentUser.login(token);

      updateLogin(name, true);
      SessionService.me().updateLogin();
    } catch (AuthenticationException e)
    {
      if (OjConfig.isDevMode())
        e.printStackTrace();
      log.warn("User signin failed.");
      
      updateLogin(name, false);
      return false;
    }

    return true;
  }
  
  public boolean autoLogin(UserModel userModel, boolean rememberMe)
  {
    String name = userModel.getName();
    String password = userModel.getPassword();
    Subject currentUser = ShiroKit.getSubject();
    UsernamePasswordToken token = new UsernamePasswordToken(name, password);
    token.setRememberMe(rememberMe);

    try
    {
      currentUser.login(token);

      updateLogin(name, true);
      SessionService.me().updateLogin();
    } catch (AuthenticationException e)
    {
      if (OjConfig.isDevMode())
        e.printStackTrace();
      log.warn("User signin failed.");
      
      updateLogin(name, false);
      return false;
    }

    return true;
  }
  
  private void addExp(UserExtModel userExtModel, int incExp)
  {
    int exp = userExtModel.getExperience() + incExp;
    int credit = userExtModel.getCredit() + incExp;
    int level = Arrays.binarySearch(OjConfig.level.toArray(), exp);
    level = level<0 ? -level : level+2;
    
    userExtModel.setCredit(credit).setExperience( exp).setLevel(level); // no update
  }
  
  public int checkin(UserExtModel userExtModel)
  {
    int timestamp = Tool.getDayTimestamp();
    int checkin = userExtModel.getCheckin();
    int checkinTimes = userExtModel.getCheckinTimes();
    int level = userExtModel.getLevel();
    
    if (checkin < timestamp)
    {
      checkinTimes = (checkin + OjConstants.DAY_TIMESTAMP < timestamp) ? 1 : checkinTimes + 1;
      int incExp = Math.min(checkinTimes, level);
      int totalCheckin = userExtModel.getTotalCheckin() + 1;
      
      addExp(userExtModel, incExp);
      userExtModel.setCheckin(OjConfig.timeStamp).setCheckinTimes(checkinTimes).setTotalCheckin(totalCheckin).update();
      return incExp;
    }
    
    return 0;
  }
  
  public boolean isCheckin(UserModel userModel)
  {
    int checkin = userModel.getInt("checkin"); // UserModel does not have "checkin"
    
    if (checkin < Tool.getDayTimestamp())
    {
      return false;
    }
    else
    {
      userModel.put("isCheckin", checkin); // use lastCheckin?
      return true;
    }
  }
  
  /**
   * User logout in Shiro session.
   */
  public void logout()
  {
    UserModel userModel = getCurrentUser();
    if (userModel != null)
    {
      //int online = userModel.getOnline();
      //int login = userModel.getLoginTime();
      
      //log.info("online: " + online + " login: " + login + " current: " + OjConfig.timeStamp);
      // TODO online time is incorrect
      //online += (OjConfig.timeStamp - login) / 60;
      //userModel.setOnline(online).update();
      evictCache(userModel.getUid());
    }

    ShiroKit.getSubject().logout();
  }
  
  /**
   * user signup
   * @param userModel
   * @return
   * @throws Exception 
   */
  public boolean signup(UserModel userModel)
  {
    String name = HtmlEncoder.text(userModel.getName());
    String password = BCrypt.hashpw(userModel.getPassword(), BCrypt.gensalt());
    String email = userModel.getEmail();
    String verifyEmailToken = UUID.randomUUID().toString();
    
    int ctime = OjConfig.timeStamp;
    UserModel newUser = new UserModel();
    newUser.setName(name).setPassword(password).setEmail(email).setRegEmail(email);
    newUser.setToken(verifyEmailToken).setCtime(ctime).setMtime(ctime);
    
    if (newUser.save())
    {
      int uid = newUser.getUid();
      Db.update("INSERT INTO user_role (rid,uid) SELECT id,? FROM role WHERE name='user'", uid);
      
      UserExtModel userExt = new UserExtModel();
      userExt.setUid(uid).save();
      //password = userModel.getStr("pass");
      //return login(name, password, false);
      
      ojService.sendVerifyEmail(name, email, verifyEmailToken);
      return true;
    }
    
    return false;
  }
  
  public UserModel signup(String email, WebLoginModel webLogin) throws Exception
  {
    String name = HtmlEncoder.text(email);
    String pass = Tool.randomPassword(9);
    String password = BCrypt.hashpw(pass, BCrypt.gensalt());
    String avatar = webLogin.getAvatar();
    String verifyEmailToken = UUID.randomUUID().toString();
    int ctime = OjConfig.timeStamp;
    
    UserModel newUser = new UserModel();
    newUser.setName(name).setPassword(password).setEmail(email).setRegEmail(email).setToken(verifyEmailToken);
    newUser.setNick(HtmlEncoder.text(webLogin.getNick())).setAvatar(avatar).setCtime(ctime).setMtime(ctime);
    
    if (newUser.save())
    {
      webLogin.setStatus(true).update();
      
      Integer uid = newUser.getUid();
      Calendar cal = Calendar.getInstance();
      name = new StringBuilder(3).append(webLogin.getType()).append(cal.get(Calendar.YEAR)).append(uid).toString();
      newUser.setName(name).update();
      
      Db.update("INSERT INTO user_role (rid,uid) SELECT id,? FROM role WHERE name='user'", uid);
      
      UserExtModel userExt = new UserExtModel();
      userExt.setUid(uid).save();
      
      Map<String, Object> paras = new HashMap<String, Object>();
      paras.put(OjConstants.BASE_URL, OjConfig.baseUrl);
      paras.put(OjConstants.SITE_TITLE, OjConfig.siteTitle);
      paras.put("nick", webLogin.getNick());
      paras.put("type", webLogin.getType());
      paras.put("name", name);
      paras.put("token", verifyEmailToken);
      paras.put("password", pass);
      paras.put("ctime", OjConfig.timeStamp);
      paras.put("expires", OjConstants.VERIFY_EMAIL_EXPIRES_TIME / OjConstants.MINUTE_IN_MILLISECONDS);
      
      ojService.sendVerifyEmail(name, email, paras);
    }
    
    return newUser;
  }
  
  /**
   * update user
   * @param userModel
   * @return
   */
  public boolean updateUser(UserModel userModel)
  {
    UserModel newUser = getCurrentUser();
    String password = userModel.getPassword();
    
    if (StringUtil.isNotBlank(password))
    {
      password = BCrypt.hashpw(password, BCrypt.gensalt());
      newUser.setPassword(password);
    }
    
    newUser.setUid(getCurrentUid());
    newUser.setNick(HtmlEncoder.text(userModel.getNick()));
    newUser.setSchool(HtmlEncoder.text(userModel.getSchool()));
    newUser.setRealName(HtmlEncoder.text(userModel.getRealName()));
    newUser.setBlog(HtmlEncoder.text(userModel.getBlog()));
    newUser.setEmail(HtmlEncoder.text(userModel.getEmail()));
    newUser.setPhone(HtmlEncoder.text(userModel.getPhone()));
    newUser.setGender(HtmlEncoder.text(userModel.getGender()));
    newUser.setLanguage(userModel.getLanguage());
    newUser.setQQ(userModel.getQQ());
    newUser.setMtime(OjConfig.timeStamp);
    updateCache(newUser);
    
    return newUser.update();
  }
  
  /**
   * Update user login time and loginlog.
   * @param name user name.
   * @param success true if user login sucessfully.
   * @return
   */
  public boolean updateLogin(String name, boolean success)
  {
    Record loginLog = new Record();
    String ip = SessionService.me().getHost();
    
    if (success)
    {
      UserModel userModel = getCurrentUser();
      if (userModel.getEmailVerified())
      {
        userModel.setToken(null); // resetPassword token
      }
      userModel.setLoginTime(OjConfig.timeStamp).setLoginIP(ip).update();
      updateCache(userModel);
      
      loginLog.set("uid", userModel.getUid());
    }
    
    loginLog.set("name", name).set("ip", ip).set("ctime", OjConfig.timeStamp).set("success", success);
    return Db.save("loginlog", loginLog);
  }
  
  public boolean updateEmail(UserModel userModel, String email) throws Exception
  {
    String name = userModel.getName();
    String token = UUID.randomUUID().toString();
    
    userModel.setEmail(email).setEmailVerified(false);
    userModel.setToken(token).setMtime(OjConfig.timeStamp);
    updateCache(userModel);
    
    ojService.sendVerifyEmail(name, email, token);
    
    return userModel.update();
  }
  
  public boolean incSubmission(Integer uid)
  {
    UserModel userModel = getUser(uid);
    userModel.setSubmission(userModel.getSubmission() + 1);
    updateCache(userModel);
    
    return userModel.update();
  }

  public boolean incAccepted(SolutionModel solutionModel)
  {
    Integer pid = solutionModel.getPid();
    Integer sid = solutionModel.getSid();
    Integer uid = solutionModel.getUid();
    UserModel userModel = getUser(uid);
    userModel.setAccepted(userModel.getAccepted() + 1);
    Integer lastAccepted = Db.queryInt("SELECT sid FROM solution WHERE pid=? AND uid=? AND sid<? AND result=? AND status=1 LIMIT 1", pid, uid, sid, ResultType.AC);
    if (lastAccepted == null)
    {
      userModel.setSolved(userModel.getSolved() + 1);
    }
    updateCache(userModel);
    
    return userModel.update();
  }

  public boolean revertAccepted(SolutionModel solutionModel)
  {
    if (solutionModel.getResult() != ResultType.AC)
    {
      return false;
    }
    
    Integer pid = solutionModel.getPid();
    Integer sid = solutionModel.getSid();
    Integer uid = solutionModel.getUid();
    UserModel userModel = getUser(uid);
    userModel.setAccepted(userModel.getAccepted() - 1);
    Integer lastAccepted = Db.queryInt("SELECT sid FROM solution WHERE pid=? AND uid=? AND sid<? AND result=? AND status=1 LIMIT 1", pid, uid, sid, ResultType.AC);
    if (lastAccepted == null)
    {
      userModel.setSolved(userModel.getSolved() - 1);
    }
    
    return userModel.update();
  }

  /**
   * Build user statistics.
   * @param userModel the user.
   * @return
   */
  public boolean build(UserModel userModel)
  {
    if (userModel == null)
      return false;
    
    Integer uid = userModel.getUid();
    
    userModel.set("submission", Db.queryLong("SELECT COUNT(*) FROM solution WHERE uid=? AND status=1 LIMIT 1", uid));
    userModel.set("accepted", Db.queryLong("SELECT COUNT(*) FROM solution WHERE uid=? AND result=? AND status=1 LIMIT 1", uid, ResultType.AC));
    userModel.set("solved", Db.queryLong("SELECT COUNT(DISTINCT pid) FROM solution WHERE uid=? AND result=? AND status=1 LIMIT 1", uid, ResultType.AC));
    updateCache(userModel);

    return userModel.update();
  }

  /**
   * Reset user password for recover account.
   * @param name user name.
   * @param password new password.
   * @return
   */
  public boolean resetPassword(String name, String password)
  {
    UserModel userModel = dao.getUserByName(name);
    
    userModel.setToken(null).setEmailVerified(true).setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
    return userModel.update();
  }
  
  /**
   * Check if the token is valid for reset password.
   * @param name user name.
   * @param token reset token.
   * @return true if the token is valid.
   */
  public boolean checkResetToken(String name, String token)
  {
    UserModel userModel = dao.getUserByName(name);
    
    if (userModel != null && token != null && token.equals(userModel.getToken()))
    {
      if (OjConfig.timeStamp - userModel.getMtime() <= OjConstants.RESET_PASSWORD_EXPIRES_TIME)
      {
        return true;
      }
      else
      {
        userModel.setToken(null).update();
      }
    }
    
    return false;
  }
  
  public boolean verifyEmail(String name, String token)
  {
    UserModel userModel = dao.getUserByName(name);
    
    if (userModel != null && token != null && token.equals(userModel.getToken()) && !userModel.getEmailVerified())
    {
      if (OjConfig.timeStamp - userModel.getMtime() <= OjConstants.VERIFY_EMAIL_EXPIRES_TIME)
      {
        log.info(String.valueOf(OjConfig.timeStamp - userModel.getMtime()));
        userModel.setToken(null).setEmailVerified(true).update();
        updateCache(userModel);
        
        return true;
      }
      else
      {
        userModel.setToken(null).update();
        updateCache(userModel);
        
        log.info("token expires");
        return false;
      }
    }
    
    if (OjConfig.isDevMode())
    {
      log.info(name + " " + token);
      log.info(userModel.toString());
    }
    log.info("token invlidate");
    return false;
  }
  
  /**
   * upload and resize user avatar.
   * @param file file of the avatar.
   * @param maxWidth max width of the thumbnail.
   * @param maxHeight max height of the thumbnail.
   * @param controller the controller to set attr.
   * @throws Exception
   */
  public void uploadAvatar(File file, int maxWidth, int maxHeight, OjController controller) throws Exception
  {
    ImageScaleImpl imageScale = new ImageScaleImpl();
    imageScale.resizeFix(file, file, maxWidth, maxHeight);
    
    BufferedImage srcImgBuff = ImageIO.read(file);
    controller.setAttr("width", srcImgBuff.getWidth());
    controller.setAttr("height", srcImgBuff.getHeight());
  }
  
  /**
   * cut and save user avatar.
   * @param imageSource source of image file.
   * @param x1 left of selection area.
   * @param y1 top of selection area.
   * @param x2 right of selection area.
   * @param y2 bottom of selection area.
   * @throws Exception
   */
  public void saveAvatar(String imageSource, int x1, int y1, int x2, int y2) throws Exception
  {
    int cutWidth = x2 - x1;
    int catHeight = y2 - y1;
    UserModel userModel = getCurrentUser();
    String rootPath = PathKit.getWebRootPath() + File.separator;
    String srcFileName = rootPath + imageSource;
    String ext = FileKit.getFileType(srcFileName);
    String destFileName = new StringBuilder(4).append(OjConfig.userAvatarPath).append(File.separator).append(userModel.getUid()).append(ext).toString();
    File srcFile = new File(srcFileName);
    File destFile = new File(destFileName);
    ImageScaleImpl imageScale = new ImageScaleImpl();

    imageScale.resizeFix(srcFile, destFile, OjConstants.AVATAR_WIDTH, OjConstants.AVATAR_HEIGHT, x1, y1, cutWidth, catHeight);
    FileUtil.delete(srcFile);
    destFileName = destFileName.replace(rootPath, "").replace("\\", "/");
    userModel.setAvatar(destFileName).update();
    updateCache(userModel);
  }
  
  public String saveAvatar(File srcFile) throws Exception
  {
    UserModel userModel = getCurrentUser();
    String rootPath = PathKit.getWebRootPath() + File.separator;
    String srcFileName = srcFile.getAbsolutePath();
    String ext = FileKit.getFileType(srcFileName);
    String destFileName = new StringBuilder(4).append(OjConfig.userAvatarPath).append(File.separator).append(userModel.getUid()).append(ext).toString();
    
    File destFile = new File(destFileName);
    
    FileUtil.moveFile(srcFile, destFile);
    
    destFileName = destFileName.replace(rootPath, "").replace("\\", "/");
    userModel.setAvatar(destFileName).update();
    updateCache(userModel);
    
    return destFileName;
  }
  
  /**
   * Search user by key word in scope.
   * @param scope "all", "name", "nick", "school", "email".
   * @param word key word.
   * @return the list of users.
   */
  public Page<UserModel> searchUser(int pageNumber, int pageSize, String scope, String word)
  {
    String select = "SELECT uid,name,nick,school,solved,submission";
    Page<UserModel> userList = null;
    List<Object> paras = new ArrayList<Object>();
    
    if (StringUtil.isBlank(word))
    {
      word = "No Such User!";
    }
    {
      word = new StringBuilder(3).append("%").append(word).append("%").toString();
      StringBuilder sb = new StringBuilder("FROM user WHERE (");
      
      if (StringUtil.isNotBlank(scope))
      {
        String scopes[] =
        { "name", "nick", "school", "email" };
        if (StringUtil.equalsOneIgnoreCase(scope, scopes) == -1)
        {
          return null;
        }
        sb.append(scope).append(" LIKE ? ");
        paras.add(word);
      } else
      {
        sb.append("name LIKE ? OR nick LIKE ? OR school LIKE ? OR email LIKE ?");
        for (int i = 0; i < 4; ++i)
        {
          paras.add(word);
        }
      }
      sb.append(") AND status=1 ORDER BY solved DESC,submission,uid");
      
      userList = dao.paginate(pageNumber, pageSize, select, sb.toString(), paras.toArray());
    }
    
    return userList;
  }
  
  /**
   * get user profile by name.
   * @param name string of user name.
   * @return UseModel with submitted problems.
   */
  public UserModel getUserProfile(String name)
  {
    UserModel userModel = null;
    
    if (name == null)
    {
      userModel = getCurrentUser();
    } else
    {
      userModel = getUserByName(name);
    }
    
    if (userModel != null)
    {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      userModel.put("createTime_t", sdf.format(new Date(userModel.getCtime() * 1000L)));
      userModel.put("loginTime_t", sdf.format(new Date(userModel.getLoginTime() * 1000L)));
      userModel.put("rank", getUserRank(userModel.getUid()));
      userModel.put("problems", getSubmittedProblems(userModel.getUid()));
    }
    
    return userModel;
  }
  
  /**
   * get user's login logs.
   * @param pageNumber
   * @param pageSize
   * @return
   */
  public Page<Record> getLoginlog(int pageNumber, int pageSize)
  {
    UserModel userModel = getCurrentUser();
    Integer uid = userModel.getUid();
    String name = userModel.getName();
    
    Page<Record> logs = Db.paginate(pageNumber, pageSize, "SELECT *",
                        "FROM loginlog WHERE uid=? OR name=? ORDER BY ctime DESC", 
                        uid, name);
    return logs;
  }
  
  /**
   * archive user source code.
   * @return zip file.
   * @throws IOException
   */
  public File archiveCode() throws IOException
  {
    UserModel userModel = getCurrentUser();
    Integer uid = userModel.getUid();
    List<Record> codes = getSolvedProblems(uid);
    String userDir = new StringBuilder(3).append(OjConfig.downloadPath).append(File.separator).append(userModel.getName()).toString();
    File userDirFile = new File(userDir);
    FileUtil.mkdirs(userDirFile);
    
    for (Record code : codes)
    {
      String problemDir = new StringBuilder(3).append(userDir).append(File.separator).append(code.get("pid")).toString();
      FileUtil.mkdirs(problemDir);
      
      String ext = OjConfig.languageType.get(code.get("language")).getExt();
      StringBuilder sb = new StringBuilder(10).append(problemDir).append(File.separator).append(code.get("sid")).append("_");
      sb.append(code.get("time")).append("MS_").append(code.get("memory")).append("KB").append(".").append(ext);
      
      File file = new File(sb.toString());
      if (file.createNewFile() == false)
      {
        log.info("Create file failed: " + sb.toString());
        continue;
      }
      
      FileUtil.writeString(file, code.getStr("source"));
    }
    
    ZipUtil.zip(userDirFile);
    File zipFile = new File(userDirFile.getAbsolutePath() + ".zip");
    
    return zipFile;
  }
  
  /**
   * Get current uid form Shiro.
   * @return the uid of current user or null.
   */
  public Integer getCurrentUid()
  {
    Subject currentUser = ShiroKit.getSubject();
    if (currentUser == null)
      return null;

    Object principal = currentUser.getPrincipal();
    if (principal == null)
      return null;
    
    return (Integer) principal;
  }
  
  public UserModel getUser(Integer uid)
  {
    if (OjConfig.isDevMode())
    {
      return getUserByUid(uid);
    }
    else
    {
      return dao.findFirstByCache("user", uid, "SELECT * FROM user WHERE uid=?", uid);
    }
  }

  /**
   * Get current user by uid.
   * @return current user or null.
   */
  public UserModel getCurrentUser()
  {
    return getUser(getCurrentUid());
  }
  
  public UserModel getCurrentUserExt()
  {
    UserModel userModel = dao.getUserExt(getCurrentUid());
    log.info(userModel.toString());
    int exp = userModel.getInt("experience"); // UserModel does not have experience
    int level = userModel.getInt("level"); // UserModel does not have level
    int lastExp = 0;
    
    if (level > 1)
    {
      lastExp = OjConfig.level.get(level-2);
    }
    
    int nextExp = (1<<31) - 1;
    if (level - 1 < OjConfig.level.size())
    {
      nextExp = OjConfig.level.get(level-1);
    }
    
    userModel.put("nextExp", nextExp);
    userModel.put("percent", (int)((exp-lastExp)/(double)(nextExp-lastExp) * 100));
    // TODO cache?
    
    return userModel;
  }
  
  public UserModel getUserByUid(Integer uid)
  {
    return dao.findById(uid);
  }

  public UserModel getUserByName(String name)
  {
    return dao.getUserByName(name);
  }

  public Integer getUidByName(String name)
  {
    UserModel userModel = getUserByName(name);
    
    if (userModel != null)
    {
      return userModel.getUid();
    }
    return null;
  }

  public UserModel getUserByEmail(String email)
  {
    return dao.getUserByEmail(email);
  }

  public UserModel getUserByNameAndEmail(String name, String email)
  {
    return dao.getUserByNameAndEmail(name, email);
  }

  public UserModel getUserInfoByName(String name)
  {
    return dao.getUserInfoByName(name);
  }

  public UserModel getUserInfoByUid(Integer uid)
  {
    return dao.getUserInfoByUid(uid);
  }

  public int getUserRank(Integer uid)
  {
    return dao.getUserRank(uid);
  }

  public Page<UserModel> getUserRankList(int pageNumber, int pageSize)
  {
    return dao.getUserRankList(pageNumber, pageSize);
  }

  public Page<UserModel> getUserRankListDataTables(int pageNumber, int pageSize, String sSortName, String sSortDir, String sSearch)
  {
    List<Object> param = new ArrayList<Object>();
    String sql = "SELECT *";
    StringBuilder sb = new StringBuilder().append("FROM user WHERE 1=1");

    if (StringUtil.isNotEmpty(sSearch))
    {
      sb.append(" AND (name LIKE ? OR realName LIKE ?)");
      param.add(new StringBuilder(3).append("%").append(sSearch).append("%").toString());
      param.add(new StringBuilder(3).append("%").append(sSearch).append("%").toString());
    }
    sb.append(" ORDER BY ").append(sSortName).append(" ").append(sSortDir).append(", uid");

    return dao.paginate(pageNumber, pageSize, sql, sb.toString(), param.toArray());
  }

  public List<Record> getSubmittedProblems(Integer uid)
  {
    return Db.find("SELECT p.title, p.pid, MIN(result) AS result FROM solution s LEFT JOIN problem p ON p.pid=s.pid WHERE s.uid=? AND s.status=1 GROUP BY s.pid", uid);
  }
  
  public List<Record> getSolvedProblems(Integer uid)
  {
    return Db.find("SELECT * FROM solution WHERE uid=? AND result=? AND status=1 GROUP BY pid", uid, ResultType.AC);
  }
  
  public boolean checkPassword(Integer uid, String password)
  {
    String storedHash = dao.findById(uid).getPassword();
    return BCrypt.checkpw(password, storedHash);
  }

  public boolean containsEmail(String email)
  {
    return dao.getUserByEmail(email) != null;
  }

  public boolean containsUsername(String username)
  {
    return dao.getUserByName(username) != null;
  }

  public boolean isAdmin()
  {
    try
    {
      return ShiroKit.hasPermission("admin");
    } catch (UnknownSessionException e)
    {
      if (OjConfig.isDevMode())
        e.printStackTrace();
      log.warn(e.getLocalizedMessage());
    }
    return false;
  }

  public boolean containsEmailExceptThis(Integer uid, String email)
  {
    return dao.containsEmailExceptThis(uid, email);
  }

  public Object getUserField(Integer uid, String name)
  {
    UserModel userModel = dao.getUserInfoByUid(uid);
    if (userModel == null)
    {
      return null;
    }
    
    return userModel.get(name);
  }

  private void updateCache(UserModel user)
  {
    CacheKit.put("user", user.getUid(), user);
  }
  
  private void evictCache(Integer uid)
  {
    CacheKit.remove("user", uid);
  }
}
