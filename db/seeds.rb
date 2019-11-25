require 'rest-client'
require 'json'
require 'pry'
require 'dotenv/load'

API_KEY = ENV['API_KEY']

#deletes everything from the database each time we seed
puts "ready to delete"
Student.delete_all
Professor.delete_all
Course.delete_all
House.delete_all
puts "deleted all students, professors, courses from DB"

#reading from the HP API and parsing into a hash
response_string = RestClient.get("https://www.potterapi.com/v1/characters?key=#{API_KEY}")
response_hash = JSON.parse(response_string)

response_string_houses = RestClient.get("https://www.potterapi.com/v1/houses?key=#{API_KEY}")
response_hash_houses = JSON.parse(response_string_houses)

#looking student and professor roles and adding them to the appropriate table
puts "starting to seed"
response_hash_houses.each do |house|
  colors = house["colors"].join(", ")
  values = house["values"].join(", ")
  House.create(name: house["name"], colors: colors, values: values, mascot: house["mascot"], house_ghost: house["houseGhost"], founder: house["founder"])
end

response_hash.each do |character|
  unless character["role"].nil?
      if character["school"] == "Hogwarts School of Witchcraft and Wizardry"
          if character["role"].downcase.include?("student")
              #add a new student
              house_id = House.find_by(name: character["house"]).id
              Student.create(name: character["name"], dumbledores_army: character["dumbledoresArmy"], order_of_the_phoenix: character["orderOfThePhoenix"], house_id: house_id)
          elsif character["role"].downcase.include?("professor")
              #add a new professor
              specialty = character["role"].split(", ")[-1]
              Professor.create(name: character["name"], dumbledores_army: character["dumbledoresArmy"], order_of_the_phoenix: character["orderOfThePhoenix"], specialty: specialty)
          end
      end
  end
end
puts "done seeding"

#randomly adds 3 courses to each student from our available courses
puts "generating courses"
Student.all.each do |student|
  data = Course.listings.sample(3)
  data.each do |datum|
    Course.create(name: datum[0], subject: datum[1], student_id: student.id, professor_id: datum[2])
  end
end
puts "generated courses"