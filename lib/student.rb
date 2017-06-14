class Student
  attr_accessor :name, :grade
  attr_reader :id, :db
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade, id = nil)
    @db = DB[:conn]
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
  #  (<<-EOT)
    table_create = "CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade TEXT
    )"
    # EOT
   DB[:conn].execute(table_create)
  end


  def self.drop_table
    table_drop = "DROP TABLE students"
    DB[:conn].execute(table_drop)
  end

  def save
    #insert into here.
    save = "INSERT INTO students (name, grade) VALUES ('#{self.name}', '#{self.grade}')"
    DB[:conn].execute(save)

    get_last_id = "SELECT id FROM students ORDER BY id DESC LIMIT 1"
    ## WILL RETURN [[id]] from database
    @id = DB[:conn].execute(get_last_id).flatten[0]

  end

  def self.create(attr_hash)
    #new then save.
    name = attr_hash.values[0]
    grade = attr_hash.values[1]
    student = Student.new(name, grade)
    student.save
    student
  end

end
