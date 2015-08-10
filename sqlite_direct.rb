require 'sqlite3'

class SqliteDirect
  def connect(database_name)
    @conn = SQLite3::Database.open("#{database_name}.db")
  end

  def new_table
    @conn.execute("CREATE TABLE IF NOT EXISTS catalog (
id SERIAL PRIMARY KEY,
name TEXT NOT NULL,
type TEXT,
nation TEXT,
epoch TEXT);")
  end

  def clear_table
    @conn.execute("DELETE FROM catalog;")
  end

  def insert(array)
    @conn.transaction
    array.each do |x|
      @conn.execute( "INSERT INTO catalog (name, type, nation, epoch)
      VALUES ('#{x.name.gsub("'", "''")}','#{x.type}','#{x.nation.gsub("'", "''")}','#{x.epoch}');")
    end
    @conn.commit
  end

  def disconnect
    @conn.close
  end
end