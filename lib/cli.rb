class CommandLineInterface

    @@user_student

    def runner
        greet
        main_menu
    end

    def greet
        puts "Welcome to Hogwarts School of Witchcraft and Wizardry!"

        puts "What is your name?"
        name = gets.chomp.strip

        puts "Are you a returning student? (Y/N)"
        returning_student = gets.chomp.strip
        parsed_returning_student = valid_input(returning_student)

        if parsed_returning_student == "Y"  #check them in / look them up
            welcome_back(name)
        else                                #make a new student
            create_student(name)
        end

    end

    def valid_input(input)
        valid = false

        while valid == false
            if input == "Y" || input =="N"
                valid = true
            else
                puts "Please enter Y or N"
                input = gets.chomp.strip
            end
        end
        input
    end

    def self.user_student
        @@user_student
    end

    def welcome_back(name)
        student = Student.find_by(name: name)
        if student
            @@user_student = student
            puts "Welcome back, #{name}! Your bags are upstairs, continue to the Great Hall!"

            if student.dumbledores_army
                puts "Psst, I hear there's a DA meeting in a couple hours"
            end

            if student.order_of_the_phoenix
                puts "Oh, and there's important Order business. Take this envelope."
            end
        else
            puts "sorry, we can't find you."
            create_student(name)
        end
        
    end

    def create_student(name)
        puts "Do you want to create a new student? (Y/N)"
        answer = gets.chomp.strip
        parsed_answer = valid_input(answer)

        if parsed_answer == "Y"         #call make a new student
            @@user_student = Student.create(name: name, dumbledores_army: false, order_of_the_phoenix: false)
            puts "You're in!"
        else
            puts "bye!"
            exit                        #exit
        end
    end



    #__________________________________________________________________________________________________________________


    # MENU STUFF

    def valid_option(input, num_options)
        valid = false

        while valid == false
            if (1..num_options).to_a.include?(input.to_i)
                valid = true
            else
                puts "Please enter a valid option number, between 1 and #{num_options}"
                input = gets.chomp.strip
            end
        end
        input
    end

    def main_menu
        puts "Please select an option:"
        puts "1. Student Portal"
        puts "2. Course Data"
        puts "3. Professor Information"
        puts "4. Exit"
        option = gets.chomp.strip
        parsed_option = valid_option(option, 4)

        case parsed_option
        when "1"
            student_menu
        when "2"
            course_menu
        when "3"
            professor_menu
        when "4"
            puts "BYEE!"
            exit
        end
    end

    def student_menu
        puts "Please select an option:"
        puts "1. See all of my courses"
        puts "2. See all of my professors"
        puts "3. See all of my classmates"
        puts "4. See the names of all students"
        puts "5. See if a student is my classmate"
        puts "6. Add a course"
        puts "7. Drop a course"
        puts "8. Join or leave a secret organization"
        puts "9. Drop out of Hogwarts"
        puts "10. Back to main menu"
        option = gets.chomp.strip
        parsed_option = valid_option(option, 10)

        case parsed_option
        when "1"
            puts @@user_student.course_names

            puts "Would you like to go back to the "
            student_menu
        when "2"
            puts @@user_student.prof_names
            student_menu
        when "3"
            puts @@user_student.my_classmates
            student_menu
        when "4"
            puts Student.names
        when "5"
            puts "Which student?"
            input = gets.chomp.strip
            if Student.find_by(name: input)
                puts @@user_student.is_classmate?(input)
            else
                puts "Sorry, we can't find that student."
                #maybe add functionality to have them try again
            end
        when "6"
            puts "Please select one of the below options:"
            puts Course.render_listings
            course_num = gets.chomp.strip.to_i
            # clean this input: must be an integer
            added = @@user_student.add_course(course_num)
            if added
                puts "You've been added to #{Course.listings[course_num-1][0]}"
            end
        when "7"
            if @@user_student.course_names.length != 0
                puts "Here are your courses:"
                puts @@user_student.course_names
                puts "Type the name of the course you would like to drop:"
                to_delete = gets.chomp.strip
                # clean this input: it must be a valid course name
                course_to_delete = Course.find_by(name: to_delete)
                if course_to_delete
                    @@user_student.drop_course(course_to_delete)
                    puts "You've successfully dropped #{course_to_delete.name} from your schedule."
                else
                    puts "Sorry, we couldn't find that course in your schedule."
                    #maybe add functionality to have them try again
                end
            else
                puts "Looks like you don't have any courses for this semester yet!"
            end
            
        when "8"
            puts "Select a secret organization number:"
            puts "1. Dumbledore's Army"
            puts "2. Order of the Phoenix"
            org = gets.chomp.strip
            #validate number is 1 or 2
            case org
            when "1"
                if @@user_student.dumbledores_army
                    puts "You are currently a member of Dumbledore's Army. Would you like to leave? (Y/N)"
                    da_answer1 = gets.chomp.strip
                    #validate answer is Y or N
                    case da_answer1
                    when "Y"
                        @@user_student.leave_army
                        puts "You've left the secret organization"
                    when "N"
                    end
                else
                    puts "You are currently not a member of Dumbledore's Army. Would you like to join? (Y/N)"
                    da_answer2 = gets.chomp.strip
                    #validate answer is Y or N
                    case da_answer2
                    when "Y"
                        @@user_student.join_army
                        puts "You've joined the secret organization"
                    when "N"
                    end
                end
            when "2"
                if @@user_student.order_of_the_phoenix
                    puts "You are currently a member of the Order of the Phoenix. Would you like to leave? (Y/N)"
                    op_answer1 = gets.chomp.strip
                    #validate answer is Y or N
                    case op_answer1
                    when "Y"
                        @@user_student.leave_order
                        puts "You've left the secret organization"
                    when "N"
                    end
                else
                    puts "You are currently not a member of the Order of the Phoenix. Would you like to join? (Y/N)"
                    op_answer2 = gets.chomp.strip
                    #validate answer is Y or N
                    case op_answer2
                    when "Y"
                        @@user_student.join_order
                        puts "You've joined the secret organization"
                    when "N"
                    end
                end
            end
        when "9"
            puts "Are you sure you want to drop out of Hogwarts? (Y/N)"
            answer = gets.chomp.strip
            #validate answer is Y/N
            case answer
            when "Y"
                @@user_student.get_expelled
                puts "Have a nice life"
                exit
            when "N"
            end
        when "10"
            main_menu
        end
    end

    def course_menu

    end

    def professor_menu

    end

end