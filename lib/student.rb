class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = 1)
    @name = name
    @id = id
    @grade = grade
  end

  def self.create_table#name?
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table #name?
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, @name, @grade)
  end

  def self.create(name:, grade:)
    new_student = self.new(name, grade)
    new_student.save
    new_student
  end
end
