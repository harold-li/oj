package com.power.oj.util.model;

public class Column
{
  private String name;
  private String field;
  private String type;
  
  public Column(String name)
  {
    this.name = name;
    this.field = convertInv(name);
  }

  public Column(String name, String type)
  {
    this.name = name;
    this.field = convertInv(name);
    this.type = converType(type);
  }

  public void setName(String name)
  {
    this.name = name;
  }
  
  public String getName()
  {
    return name;
  }

  public void setField(String field)
  {
    this.field = field;
  }
  
  public String getField()
  {
    return field;
  }

  public String getType()
  {
    return type;
  }

  public void setType(String type)
  {
    this.type = type;
  }
  
  private String convertInv(String name)
  {
    boolean flag = false;
    StringBuilder sb = new StringBuilder();
    
    for (int i=0; i<name.length(); ++i)
    {
      char c = name.charAt(i);
      String tmp = String.valueOf(c);
      if (Character.isLowerCase(c))
      {
        flag = true;
      }
      else
      {
        if (flag && Character.isUpperCase(c))
        {
          sb.append("_");
        }
        flag = false;
      }
      
      sb.append(tmp);
    }
    return sb.toString();
  }
  
  private String converType(String type)
  {
    if ("tinyint(1)".equals(type))
      return "Boolean";
    int pos = type.indexOf('(');
    if (pos > 0)
    {
      type = type.substring(0, pos);
    }
    
    switch (type)
    {
      case "varchar":
      case "char":
      case "enum":
      case "set":
      case "text":
      case "tinytext":
      case "mediumtext":
      case "longtext": 
        return "String";
      case "bit": 
        return "Boolean";
      case "int":
      case "integer":
      case "tinyint":
      case "smallint":
      case "mediumint": 
        return "Integer";
      case "date":
      case "year": 
        return "java.sql.Date";
      case "time": 
        return "java.sql.Time";
      case "timestamp":
      case "datetime": 
        return "java.sql.Timestamp";
      case "unsigned bigint": 
        return "java.math.BigInteger";
      case "decimal":
      case "numeric": 
        return "java.math.BigDecimal";
      case "bigint": 
        return "Long";
      case "float": 
        return "Float";
      case "real":
      case "double": 
        return "Double";
      case "binary":
      case "varbinary":
      case "tinyblob":
      case "blob":
      case "mediumblob":
      case "longblob": 
        return "byte[]";
    }

    return null;
  }
  
  public String getMethod()
  {
    switch (type)
    {
      case "String": return "Str";
      case "Integer": return "Int";
      case "java.sql.Date": return "Date";
      case "java.sql.Time": return "Time";
      case "java.sql.Timestamp": return "Timestamp";
      case "java.math.BigInteger": return "BigInteger";
      case "java.math.BigDecimal": return "BigDecimal";
      case "byte[]": return "Bytes";
    }
    return type;
  }
}