class Student 
  GRADE = %w(A B C D)
  attr_accessor :name, :contact, :grade

  def initialize(name, contact, grade)
    @name = name
    @contact = contact
    @grade = grade
  end

  def self.display_grade
    puts "Please select Grades"
    GRADE.each do |grade|
      print "#{grade}  "
    end
    puts "\n----------------------"
  end
end
  
  def check_unique_student_name?(name,students)
    students.each do |stu|
      if stu.name == name 
        puts "Student Name already Exist .. "
        return true
      end 
    end
    return false
  end

  #check for valid grade 
  def check_valid_grade?(grade)
    if Student::GRADE.include?(grade)
      return true
    else
      system("clear")
      puts "Please select valid Grade"
      Student.display_grade 
      return false
    end
  end

  # Getting Student Details
  def get_student_details(grade="",students)
    name = ""
    loop do 
      print "Enter the Student Name : "
      name = gets.chomp
      break unless check_unique_student_name?(name,students)
    end 
    print "Enter the Contact Number : "
    contact = gets.chomp
    if grade == ""
      Student.display_grade
      loop do
        print "Enter the Grade : "
        grade = gets.chomp
        break if check_valid_grade?(grade)
      end
    end
    student = Student.new(name,contact,grade)
    system("clear")
    puts "New Student Added Successfully ... "
    puts "-----------------------------------"
    return student
  end

  # Display Student List
  def display_student_details(students) 
    system("clear")
    puts "---------------------------------"
    puts "Name     |  Contact   |  Grade  "
    puts "---------------------------------"
    if !students.empty?
      students.each do |student|
        print "#{student.name}    "
        print "#{student.contact}   "
        print "#{student.grade}"
        puts "\n---------------------------------" 
      end
    else
      puts "No Record Found"
    end
    puts "\n---------------------------------"
  end

  # Add Gradewise Student Details
  def add_grade_wise_student(students)
    system("clear")
    grade = ""
    Student.display_grade
    loop do
      print "Please Enter Grade :"
      grade = gets.chomp.to_s
      break if check_valid_grade?(grade)
    end
    get_student_details(grade, students)
  end

  # Display Gradewise Student List
  def display_gradewise_student_list(students)
    system("clear")
    Student.display_grade
    grade = ""
    loop do
      print "Enter the Grade : "
      grade = gets.chomp
      break if check_valid_grade?(grade)
    end
    temp = []
    students.each do |student|
      if student.grade == grade
        temp << student
      end
    end
    sort_by_name = temp.sort_by { |object| object.name }
    display_student_details(sort_by_name)
  end

  #Display Gradewise and Student name wise sorted List of Student
  def display_gradewise_soted_list_of_student(students)
    system("clear")
    temp = students.sort_by{ |object| [object.grade,object.name] }
    display_student_details(temp)
  end

 students = []
 loop do
  sleep 0.1
  puts "1. Add Student Details "
  puts "2. Display all Student Details"
  puts "3. Add a Student name to the Roster for a Grade"
  puts "4. Get a list of all students enrolled in a grade"
  puts "5. Get a sorted list of all students in all grades"
  puts "6. Exit "
  puts "-----------------------------------"
  print "Enter you choice :"
  choice = gets.chomp.to_i
  case choice
  when 1 then 
    students << get_student_details(students)
  when 2
    display_student_details(students)
  when 3 
    students << add_grade_wise_student(students)
  when 4
    display_gradewise_student_list(students)
  when 5 
    display_gradewise_soted_list_of_student(students)
  when 6 then break
  else
    puts "Please Provide valid Input .."
    puts "-----------------------------------"
  end
end
