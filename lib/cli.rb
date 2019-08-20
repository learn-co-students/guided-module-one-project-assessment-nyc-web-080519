class CommandLineInterface

    def greet
        puts "Welcome to Hogwarts School of Witchcraft and Wizardry!"
        puts "Are you a returning student? (Y/N)"
        returning_student = gets.chomp

        good_answer = false
        while good_answer == false    
            if returning_student == "Y"
                #something
                good_answer = true
            elsif returning_student == "N"
                #something
                good_answer = true
            else
                puts "Please enter Y or N"
            end
        end

        puts "What is your name?"
        input = gets.chomp
        puts input
    end

end