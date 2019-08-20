class CommandLineInterface

    def greet
        puts "Welcome to Hogwarts School of Witchcraft and Wizardry!"

        puts "What is your name?"
        name = gets.chomp

        puts "Are you a returning student? (Y/N)"
        returning_student = gets.chomp

        good_answer = false
        while good_answer == false    
            if returning_student == "Y"
                #check them in / look them up
                check_in(name)
                good_answer = true
            elsif returning_student == "N"
                #something
                good_answer = true
            else
                puts "Please enter Y or N"
            end
        end


    end

    def check_in(name)
        student = Student.find_by(name: name)
        if student
            puts "Welcome back, #{name}! Your bags are upstairs, continue to the Great Hall!"
            if student.dumbledores_army
                puts "Psst, I hear there's a DA meeting in a couple hours"
            end
            if student.order_of_the_phoenix
                puts "Oh, and there's important Order business. Take this envelope."
            end
        else
            puts "sorry, we can't find you."
        end
        
    end

end