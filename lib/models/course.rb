class Course < ActiveRecord::Base

    belongs_to :professor
    belongs_to :student

    #available courses: course name, subject, professor_id
    @@listings = [
        ["Intro to Ancient Runes", "Ancient Runes", 1],
        ["Intro to History of Magic", "History of Magic", 2],
        ["Intro to Muggle Studies", "Muggle Studies", 3],
        ["Advanced Muggle Studies", "Muggle Studies", 4],
        ["Intro to Dark Arts", "Dark Arts", 5],
        ["Intro to Charms", "Charms", 6],
        ["Advanced Charms", "Charms", 6],
        ["Intro to Care of Magical Creatures", "Care of Magical Creatures", 7],
        ["Advanced Care of Magical Creatures", "Care of Magical Creatures", 8],
        ["Intro to Defence Against the Dark Arts", "Defence Against the Dark Arts", 12],
        ["Advanced Defence Against the Dark Arts", "Defence Against the Dark Arts", 10],
        ["Intro to Transfiguration", "Transfiguration", 11],
        ["Advanced Transfiguration", "Transfiguration", 11],
        ["Intro to Astronomy", "Astronomy", 13],
        ["Intro to Potions", "Potions", 14],
        ["Advanced Potions", "Potions", 15],
        ["Intro to Herbology", "Herbology", 16],
        ["Advanced Herbology", "Herbology", 16],
        ["Intro to Divination", "Divination", 17],
        ["Advanced Divination", "Divination", 19],
        ["Intro to Arithmancy", "Arithmancy", 18]
    ]

    #returns our course listings class variable array
    def self.listings
        @@listings
    end

    #returns the string names of each course in the listings array
    #need to use this when we show the user the listings,
    #so the order of courses shown to them matches the order we are using to add a course
    def self.render_listings
        self.listings.map do |listing|
            listing[0]
        end
    end

    #returns an array of all unique course names as strings
    def self.names(array = self.all)
        array.map do |course|
            course.name
        end.uniq
    end

    #helper function that returns an array of course objects of a particular subject
    def self.topical_courses(topic)
        self.all.select do |course|
            course.subject == topic
        end
    end

    #returns an array of students in a particular course
    def students
        #look through all courses and select all courses that match the name and prof id as the course instance we're on
        course_objects = self.class.all.select do |course|
            (course.name == self.name) && (course.professor_id == self.professor_id)
        end
        #of those courses, we only want the students name
        student_names = course_objects.map do |obj|
            Student.find_student(obj.student_id).name
        end
    end

    #returns a course name of the most popular course --> has the most students
    def self.most_popular
        self.all.max_by{ |course| course.students.count}.name
    end

    #returns a course name of the least popular course --> has the least students
    def self.least_popular
        self.all.min_by{ |course| course.students.count}.name
    end

    #return an array of courses where subject matches the subject we're looking for
    def self.find_by_subject(topic)
        topic_courses = self.topical_courses(topic)
        self.names(topic_courses)
    end

    #return an array of courses where size (count of students) is <= the size we want
    def self.find_by_size(size)
        sized_courses = self.all.select { |course| course.students.count <= size }
        self.names(sized_courses)
    end

    #return an array of profs names that teach within the given subject
    def self.prof_by_subject(subject)
        topic_courses = self.topical_courses(subject)
        topic_courses.map do |course|
            Professor.find_prof(course.professor_id).name
        end.uniq
    end

end