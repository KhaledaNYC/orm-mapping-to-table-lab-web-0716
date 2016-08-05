class Student
attr_reader :id
attr_accessor :name, :grade
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
  sql =  <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
      )
      SQL
  DB[:conn].execute(sql)
end

def self.drop_table
sql =  <<-SQL
  DROP TABLE students
    SQL
DB[:conn].execute(sql)
end

def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?);
    SQL
    DB[:conn].execute(sql,name,grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(attributes)
    name = attributes[:name]
    grade = attributes[:grade]
    puts name, grade
    new_stu = Student.new(name,grade)
    new_stu.save
    new_stu
  end
end
