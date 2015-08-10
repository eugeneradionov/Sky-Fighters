require 'mysql'

class MysqlDirect
  def connect(database_name)
    @conn = Mysql.connect('localhost' , 'eugene', 'Astra42', "#{database_name}")
  end

  def new_table
    @conn.query("CREATE TABLE IF NOT EXISTS catalog (
id SERIAL PRIMARY KEY,
name TEXT NOT NULL,
type TEXT,
nation TEXT,
epoch TEXT);")
  end

  def clear_table
    @conn.query("TRUNCATE catalog;")
  end

  def insert(array)
    @conn.query("SET NAMES UTF8")
    @conn.autocommit false
    array.each do |x|
      @conn.query( "INSERT INTO catalog (name, type, nation, epoch)
      VALUES ('#{x.name.gsub("'", "''")}','#{x.type}','#{x.nation.gsub("'", "''")}','#{x.epoch}');")
    end
    @conn.commit
  end

  def disconnect
    @conn.close
  end
end