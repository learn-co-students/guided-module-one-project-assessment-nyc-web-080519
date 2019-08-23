class Student < ActiveRecord::Base

    has_many :courses
    has_many :professors, through: :courses
    belongs_to :house

    #returns an array of all student names
    #defaults to self.all unless a different array is passed in
    def self.names(array = self.all)
        array.map do |student|
            student.name
        end
    end

    #return an array of course names for an instance of a student
    def course_names
        self.courses.reload.map do |course|
            course.name
        end
    end

    #return an array of prof names for an instance of a student
    def prof_names
        self.professors.reload.map do |prof|
            prof.name
        end
    end

    # id 1 = DA, id 2 = OP from menu listing in cli.rb
    # updates DA or OP attribute in a student instance
    def update_org(org_name, change)
        if org_name == "Dumbledore's Army"
            self.update(dumbledores_army: change)
        elsif org_name == "Order of the Phoenix"
            self.update(order_of_the_phoenix: change)
        else
            puts "Sorry, you didn't enter a valid org id"
        end
    end

    #returns an array of student names who are in DA
    def self.da_members
        student_objs = self.all.select do |student|
            student.dumbledores_army
        end
        self.names(student_objs)
    end

    #returns an array of student names who are in OP
    def self.op_members
        student_objs = self.all.select do |student|
            student.order_of_the_phoenix
        end
        self.names(student_objs)
    end

    # remove yourself from Hogwarts
    def get_expelled
        #iterate through all of my courses and drop them
        self.courses.each do |course|
            self.drop_course(course)
        end
        #delete ourself
        self.delete
    end

    # removes a course object from the DB
    def drop_course(course)
        course.delete
    end

    #creates a new class for that user based on user input number from class listings
    def add_course(course_num)
        listing_index = course_num - 1
        course_data = Course.listings[listing_index]
        #if the student is already enrolled in the course, don't add it again
        if self.course_names.include?(course_data[0])
            puts "\nYou're already signed up for #{course_data[0]}. You must really love it!"
            new_course = false
        else
            #create a new course with the info from our course listings
            new_course = Course.create(name: course_data[0], subject: course_data[1], student_id: self.id, professor_id: course_data[2])
        end
        !!new_course
    end

    #takes in a student name and returns true if that student is in one of their classes
    def is_classmate?(classmate)
        my_classmates.include?(classmate)
    end

    #returns an array of student names that are in my classes
    def my_classmates
        classmates = self.courses.map do |course|
            course.students
        end.flatten.uniq
        classmates.delete(self.name)
        classmates
    end

    #returns a student object that matches a student_id
    def self.find_student(student_id)
        self.find_by(id: student_id)
    end

    #returns an array of student names who are in my house
    def house_mates
        student_obj = self.class.all.select do |student|
            student.house_id == self.house_id
        end
        housemates = student_obj.map do |obj|
            obj.name
        end
        housemates.delete(self.name)
        housemates
    end

end
