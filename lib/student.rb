require_relative "../config/environment.rb"
class Student 
attr_accessor :id, :name, :grade


def initialize(id = nil, name, grade)
    @name = name
    @grade = grade
    @id = id
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
  DB[:conn].execute("DROP TABLE IF EXISTS students")
end


def save
  if self.id
    self.update
  else
    sql = "
    INSERT INTO dogs (name, breed)
    VALUES (?,?)"
    
  DB[:conn].execute(sql, self.name, self.breed)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
end

def self.create(name, breed)
    dog = self.new(name, breed)
    dog.save
    dog
  end


def self.new_from_db(row)
  id = row[0]
  name = row[1]
  grade = row[2]
  self.new(id, name, breed)
end 


def self.find_by_name(name)
  sql = "SELECT * FROM students WHERE name = ?"
  DB[:conn].execute(sql, name).map { |row| new_from_db(row) }.first
end


def update
  sql = "UPDATE students SET name = ?, grade = ? WHERE id = ?"
  DB[:conn].execute(sql, self.name, self.grade, self.id)
  end
end 
