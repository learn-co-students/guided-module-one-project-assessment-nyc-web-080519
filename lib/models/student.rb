class Student < ActiveRecord::Base

    has_many :courses
    has_many :professors, through: :courses

    #returns an array of all student names
    def self.names
        self.all.map do |student|
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

    #JOIN // LEAVE Dumbledore's Army or Order of the Phoenix
    def leave_army
        self.update(dumbledores_army: false)
    end

    def join_army
        self.update(dumbledores_army: true)
    end

    def leave_order
        self.update(order_of_the_phoenix: false)
    end

    def join_order
        self.update(order_of_the_phoenix: true)
    end

    # remove yourself from Hogwarts
    def get_expelled
        # puts "get outta here!"
        #iterate through all of my courses and drop them
        self.courses.each do |course|
            self.drop_course(course)
        end
        #delete ourself
        self.delete
    end

    # removes a course object from the DB
    def drop_course(course)
        # puts "no more tests, yay!"
        course.delete
    end

    #creates a new class for that user based on user input number from class listings
    def add_course(course_num)
        listing_index = course_num - 1
        course_data = Course.listings[listing_index]
        if self.course_names.include?(course_data[0])
            puts "You're already signed up for that course. You must really love it!"
            new_course = false
        else
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
        self.courses.map do |course|
            course.students
        end.flatten.uniq
    end

    def self.find_student(student_id)
        self.find_by(id: student_id)
    end

end
