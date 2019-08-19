class Professor < ActiveRecord::Base

    has_many :courses
    has_many :students, through: :courses

end