class House < ActiveRecord::Base

    has_many :students

    #returns an array of house names
    def self.names
        self.all.map do |house|
            house.name
        end
    end

    #returns an array of house colors
    def self.colors
        self.all.map do |house|
            house.colors
        end
    end

    #returns an array of house values
    def self.values
        self.all.map do |house|
            house.values
        end
    end

    #returns an array of house mascots
    def self.mascots
        self.all.map do |house|
            house.mascot
        end
    end

    #returns an array of house ghosts
    def self.ghosts
        self.all.map do |house|
            house.house_ghost
        end
    end

    #returns an array of house founders
    def self.founders
        self.all.map do |house|
            house.founder
        end
    end

    #returns the house name with the most students
    def self.most_popular
        self.all.max_by do |house|
            house.students.count
        end.name
    end

    #returns the house name with the least students
    def self.least_popular
        self.all.min_by do |house|
            house.students.count
        end.name
    end

    #returns an array of student names that are in a house instance
    def student_names
        self.students.map do |student|
            student.name
        end
    end
end