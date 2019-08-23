class Professor < ActiveRecord::Base

    has_many :courses
    has_many :students, through: :courses

    #returns an array of all professor names
    def self.names
        self.all.map do |prof|
            prof.name
        end
    end

    #returns an array of all professor specialties
    def self.specialties
        self.all.map do |prof|
            prof.specialty
        end
    end

    # returns a prof object based on a given professor_id
    def self.find_prof(professor_id)
        self.find_by(id: professor_id)
    end

    # returns an array of course names for courses a specific prof teaches
    def self.course_names(professor_obj)
        professor_obj.courses.map do |course|
            course.name
        end.uniq
    end

    # returns an array of student names of student a specific prof teaches
    def self.student_names(professor_obj)
        professor_obj.students.map do |student|
            student.name
        end.uniq
    end

    #return the professor with the largest number of students in all their classes
    def self.most_popular_prof
        self.all.max_by do |professor|
            professor.courses.count 
        end.name
    end

    #returns an array of prof names who are in DA
    def self.da_members
        prof_objs = self.all.select do |prof|
            prof.dumbledores_army
        end
        prof_objs.map do |obj|
            obj.name
        end
    end

    #returns an array of prof names who are in OP
    def self.op_members
        prof_objs = self.all.select do |prof|
            prof.order_of_the_phoenix
        end
        prof_objs.map do |obj|
            obj.name
        end
    end

end