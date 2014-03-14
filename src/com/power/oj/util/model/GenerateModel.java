package com.power.oj.util.model;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class GenerateModel
{
  public static void main(String[] args) throws SQLException, IOException, TemplateException
  {
    Configuration config = new Configuration();
    config.setClassForTemplateLoading(GenerateModel.class, ".");
    
    Template temp = config.getTemplate("model.tpl");
    Map<String, Table> map = new HashMap<String, Table>();
    List<String> tables = DBConn.getTableNamesByDBName();
    Table myModel = new Table();
    
    myModel.setPackageName(DBConn.p.getProperty("package"));
    myModel.setPrefix(DBConn.p.getProperty("prefix"));
    myModel.setSuffix(DBConn.p.getProperty("suffix"));
    
    for (String table : tables)
    {
      myModel.setTableName(table);
      myModel.setModelName(table);
      myModel.setColumns(DBConn.getColumnsNamesByTableName(table));
      map.put("myModel", myModel);
      
      File createFolder = new File(System.getProperty("user.dir") + "/src/" + DBConn.p.getProperty("package").replace(".", "/"));
      createFolder.mkdirs();
      temp.process(map, new FileWriter(createFolder + "/" + myModel.getModelName() + ".java"));
    }
    
    System.out.println("Completed!");
  }
}