class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)

    # Instantiates a new student class 
    # and assigns the attributes a value from the array
    
    student = Student.new
    student.id = row[0]
    student.name = row[1]
    student.grade = row[2]
    student
  end

  def self.all

    #Stores the SQL query across multiple lines
    sql = <<-SQL
    SELECT * 
    FROM students
    SQL
    # Executes the data base query
    # Iteates thgrough the array and creates a new instance
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  def self.find_by_name(name)
    #Stores the SQL query across multiple lines
    sql = <<-SQL
    SELECT * 
    FROM students
    WHERE name = ?
    LIMIT 1
    SQL
    # Executes the data base query
    # Iteates thgrough the array and creates a new instance
    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
  end

  def self.all_students_in_grade_9
    #Stores the SQL query across multiple lines
    sql = <<-SQL
    SELECT * 
    FROM students
    WHERE grade = 9
    SQL
    # Executes the data base query
    # Iteates thgrough the array and creates a new instance
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  def self.students_below_12th_grade
    #Stores the SQL query across multiple lines
    sql = <<-SQL
    SELECT * 
    FROM students
    WHERE grade < 12
    SQL
    # Executes the data base query
    # Iteates thgrough the array and creates a new instance
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  def self.first_X_students_in_grade_10(number)
    #Stores the SQL query across multiple lines
    sql = <<-SQL
    SELECT * 
    FROM students
    WHERE grade = 10
    LIMIT #{number}
    SQL
    # Executes the data base query
    # Iteates thgrough the array and creates a new instance
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  def self.first_student_in_grade_10
    #Stores the SQL query across multiple lines
    sql = <<-SQL
    SELECT * 
    FROM students
    WHERE grade = 10
    SQL
    # Executes the data base query
    # Iteates thgrough the array and creates a new instance
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end.first
  end

  def self.all_students_in_grade_X(number)
    #Stores the SQL query across multiple lines
    sql = <<-SQL
    SELECT * 
    FROM students
    WHERE grade = #{number}
    SQL
    # Executes the data base query
    # Iteates thgrough the array and creates a new instance
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end
  
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
end
