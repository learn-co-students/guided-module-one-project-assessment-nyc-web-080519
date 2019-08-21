class CommandLineInterface

    #creates a class variable that will store our student instance
    @@user_student

    def runner
        greet
        main_menu
    end

    def greet
        puts "\n\n\nWelcome to Hogwarts School of Witchcraft and Wizardry!\n\n"

        puts "What is your name?\n"
        name = gets.chomp.strip

        puts "Are you a returning student? (Y/N)\n"
        returning_student = gets.chomp.strip
        parsed_returning_student = valid_input(returning_student)

        if parsed_returning_student == "Y"  #check them in / look them up
            welcome_back(name)
        else                                #make a new student
            create_student(name)
        end

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
        puts "\nDo you want to create a new student? (Y/N)"
        answer = gets.chomp.strip
        parsed_answer = valid_input(answer)

        if parsed_answer == "Y"         #call make a new student
            @@user_student = Student.create(name: name, dumbledores_army: false, order_of_the_phoenix: false)
            puts "You're in!\n\n"
        else
            puts "bye!"
            exit                        #exit
        end
    end



    #__________________________________________________________


    def main_menu
        render_main_menu
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

    #-----------------------------------------------    
    # STUDENT MENU

    def student_menu
        render_student_menu
        option = gets.chomp.strip
        parsed_option = valid_option(option, 10)
    
        case parsed_option
        when "1"
            puts "\n\n"
            puts @@user_student.course_names
            puts "\n\n"
            student_menu
        when "2"
            puts "\n\n"
            puts @@user_student.prof_names
            puts "\n\n"
            student_menu
        when "3"
            puts "\n\n"
            puts @@user_student.my_classmates
            puts "\n\n"
            student_menu
        when "4"
            puts "\n\n"
            puts Student.names
            puts "\n\n"
            student_menu
        when "5"
            render_is_classmate
        when "6"
            render_add_course
        when "7"
            render_drop_course
        when "8"
            render_secret_orgs
        when "9"
            render_drop_out
        when "10"
            puts "\n\n"
            main_menu
        end
    end


    #-----------------------------------------------    
    # COURSE MENU


    def course_menu

    end

    #-----------------------------------------------    
    # PROFESSOR MENU


    def professor_menu

    end


    #-----------------------------------------------    
    # RENDER METHODS

    def render_main_menu
        puts "Please select an option:"
        puts "1. Student Portal"
        puts "2. Course Data"
        puts "3. Professor Information"
        puts "4. Exit"
        puts "\n\n"
    end

    def render_student_menu
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
        puts "\n\n"
    end

    def render_is_classmate
        puts "\n\nWhich student?"
        input = gets.chomp.strip
        if Student.find_by(name: input) && @@user_student.is_classmate?(input)
            puts "Yes! #{input} is in at least one of your classes."
        elsif Student.find_by(name: input)
            puts "No, #{input} isn't in any of your classes."
        else
            puts "Sorry, we can't find that student."
            #maybe add functionality to have them try again
        end
        puts "\n\n"
        student_menu
    end


    def render_add_course
        puts "\n\nPlease select one of the below options:"
        Course.render_listings.each_with_index do |listing, i|
            puts "#{i+1}. #{listing}"
        end
        #puts Course.render_listings

        course_num = gets.chomp.strip.to_i
        parsed_course_num = valid_option(course_num, Course.listings.length)
        
        added = @@user_student.add_course(parsed_course_num)
        if added
            puts "You've been added to #{Course.listings[parsed_course_num-1][0]}"
        end
        puts "\n\n"
        student_menu
    end

    def render_drop_course
        puts "\n\n"
        if @@user_student.course_names.length != 0
            puts "Here are your courses:"
            puts @@user_student.course_names
            puts "\n\n"
            puts "Type the name of the course you would like to drop:"
            to_delete = gets.chomp.strip
            # parsed_to_delete = valid_course(to_delete, @@user_student.course_names)
            # binding.pry
            # clean this input: it must be a valid course name
            course_to_delete = Course.find_by(name: to_delete, student_id: @@user_student.id)
            puts "\n\n"
            binding.pry
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
        puts "\n\n"
        student_menu
    end

    def render_secret_orgs
        puts "\n\nSelect a secret organization number:\n"
        puts "1. Dumbledore's Army"
        puts "2. Order of the Phoenix\n"
        org = gets.chomp.strip
        parsed_org = valid_option(org, 2)

        case parsed_org
        when "1"
            org_helper("Dumbledore's Army", @@user_student.dumbledores_army)
        when "2"
            org_helper("Order of the Phoenix", @@user_student.order_of_the_phoenix)
        end
        puts "\n\n"
        student_menu
    end

    def render_drop_out
        puts "\n\n"
        puts "Are you sure you want to drop out of Hogwarts? (Y/N)"
        answer = gets.chomp.strip
        parsed_answer = valid_input(answer)
        case parsed_answer
        when "Y"
            @@user_student.get_expelled
            puts "Have a nice life"
            exit
        when "N"
        end
        puts "\n\n"
        student_menu
    end


    #--------------------------------------------------------
    # VALIDATION METHODS

    # Determines if a numbered option is valid based on a chomped input and the upper bound for # of options
    def valid_option(input, num_options)
        valid = false

        while valid == false
            if (1..num_options).to_a.include?(input.to_i)
                valid = true
            else
                puts "Please enter a valid option number, between 1 and #{num_options}:"
                input = gets.chomp.strip
            end
        end
        input
    end

    # Determines if a course listing is valid based on a chomped input and a course listing sub-array. 
    # IN PROGRESS
    def valid_course(input, course_list)
        valid = false

        while valid == false
            if course_list.include?(input.to_i)
                valid = true
            else
                puts "Please enter a valid course from #{course_list}:"
                input = gets.chomp.strip
            end
        end
        input
    end

    # Determines if an input listing is valid based on a chomped input and Y / N
    def valid_input(input)
        valid = false

        while valid == false
            if input == "Y" || input =="N"
                valid = true
            else
                puts "Please enter Y or N\n"
                input = gets.chomp.strip
            end
        end
        input
    end



    #  -------------------------------------------------
    #      RENDER HELPER


    def org_helper(org_name, joined)
        if joined
            status = "are"
            change = "leave"
            changed = "left"
        else
            status = "aren't"
            change = "join" 
            changed = "joined"
        end
        puts "You #{status} currently a member of #{org_name}. Would you like to #{change}? (Y/N)"
        answer = gets.chomp.strip
        parsed_answer = valid_input(answer)

        case parsed_answer
        when "Y"
            @@user_student.update_org(org_name, !joined)
            puts "You've #{changed} #{org_name}."
        when "N"
        end
    end



end