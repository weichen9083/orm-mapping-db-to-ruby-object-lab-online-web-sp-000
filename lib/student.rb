class Student
  attr_accessor :id, :name, :grade


  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
  
  def self.new_from_db(row)
    new = self.new 
    new.id = row[0]
    new.name = row[1]
    new.grade = row[2]
    new
    
  end 
  
  def self.find_by_name(name)
    sql = "select * from students where name = ? limit 1"
    what  = DB[:conn].execute(sql,name)
    self.new_from_db(what[0])
  end 
  
  def self.all_students_in_grade_9
    sql = "select * from students where grade = 9"
    DB[:conn].execute(sql)
    
  end 
  
  def self.students_below_12th_grade
    sql = "select * from students where grade < 12"
    DB[:conn].execute(sql)
    
  end 
  
  
  
  
      
end
