require 'rest-client'
require 'json'
require 'pry'

  response_string = RestClient.get('https://www.potterapi.com/v1/characters?key=$2a$10$CoI/s3EZTHwv9ZHJRmV9h.fzRl9kLkWtSFIgxckGD3AqLYHua9BeW')
  response_hash = JSON.parse(response_string)
#   binding.pry
    puts "starting to seeed"
  response_hash.each do |character|
    unless character["role"].nil?
        if character["school"] == "Hogwarts School of Witchcraft and Wizardry"
            if character["role"].downcase.include?("student")
                #add a new student
                Student.create(name: character["name"])
            elsif character["role"].downcase.include?("professor")
                #add a new professor
                Professor.create(name: character["name"])
            end
        end
    end
  end
  puts "done seeding"

