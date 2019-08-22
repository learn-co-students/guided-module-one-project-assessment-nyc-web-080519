class CommandLineInterface

    #creates a class variable that will store our student instance
    @@user_student

    def runner
        system "clear"
        pid = fork{ exec 'afplay', "Harry_Potter_Theme_Song_Hedwigs_Theme.mp3" }
        ascii_art
        greet
        main_menu
    end

    def greet
        puts "\n\nWelcome to Hogwarts School of Witchcraft and Wizardry!\n"

        puts "\nWhat is your name?"
        print "⚡️ "
        name = gets.chomp.strip

        #makes name field required, and will prompt again if you just hit enter
        until name != ""
            puts "\nWhat is your name?"
            print "⚡️ "
            name = gets.comp.strip
        end

        puts "\nAre you a returning student? (Y/N)"
        print "⚡️ "
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
            puts "\nWelcome back, #{name}! Your bags are upstairs, continue to the Great Hall!\n"

            if student.dumbledores_army
                puts "Psst, I hear there's a DA meeting in a couple of hours."
            end

            if student.order_of_the_phoenix
                puts "Oh, and there's important Order business. Take this envelope."
            end
        else
            puts "\nSorry, we can't find you."
            create_student(name)
        end
        
    end

    def create_student(name)
        puts "\nDo you want to create a new student? (Y/N)"
        print "⚡️ "
        answer = gets.chomp.strip
        parsed_answer = valid_input(answer)

        if parsed_answer == "Y"         #call make a new student
            @@user_student = Student.create(name: name, dumbledores_army: false, order_of_the_phoenix: false)
            puts "\nYou're in!\n"
        else
            puts "\nbye!\n\n"
            pid = fork{ exec 'killall', "afplay" }
            exit                        #exit
        end
    end



    #__________________________________________________________


    def main_menu
        render_main_menu
        print "⚡️ "
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
            puts "\nBYEE!\n\n"
            pid = fork{ exec 'killall', "afplay" }
            exit
        end
    end

    #-----------------------------------------------    
    # STUDENT MENU

    def student_menu
        render_student_menu
        print "⚡️ "
        option = gets.chomp.strip
        parsed_option = valid_option(option, 10)
    
        case parsed_option
        when "1"
            if @@user_student.course_names.count == 0
                puts "\nLooks like you don't have any courses for this semester yet!"
            else
                puts "\n"
                puts @@user_student.course_names
            end
            student_menu
        when "2"
            if @@user_student.prof_names.count == 0
                puts "\nLooks like you don't have any courses for this semester yet!"
            else
                puts "\n"
                puts @@user_student.prof_names
            end
            student_menu
        when "3"
            if @@user_student.my_classmates.count == 0
                puts "\nLooks like you don't have any courses for this semester yet!"
            else
                puts "\n"
                puts @@user_student.my_classmates
            end
            student_menu
        when "4"
            puts "\n"
            puts Student.names
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
        puts "\nPlease select an option:"
        puts "1. Student Portal"
        puts "2. Course Data"
        puts "3. Professor Information"
        puts "4. Exit"
    end

    def render_student_menu
        puts "\nPlease select an option:"
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
    end

    def render_is_classmate
        puts "\nWhich student?"
        print "⚡️ "
        input = gets.chomp.strip
        if Student.find_by(name: input) && @@user_student.is_classmate?(input)
            puts "\nYes! #{input} is in at least one of your courses."
        elsif Student.find_by(name: input)
            puts "\nNo, #{input} isn't in any of your courses."
        else
            puts "\nSorry, we can't find that student."
            #maybe add functionality to have them try again
        end
        student_menu
    end


    def render_add_course
        puts "\nPlease select a course (number):"
        Course.render_listings.each_with_index do |listing, i|
            puts "#{i+1}. #{listing}"
        end

        print "⚡️ "
        course_num = gets.chomp.strip.to_i
        parsed_course_num = valid_option(course_num, Course.listings.length).to_i
        
        added = @@user_student.add_course(parsed_course_num)
        if added
            puts "\nYou've been added to #{Course.listings[parsed_course_num-1][0]}."
        end
        student_menu
    end

    def render_drop_course
        if @@user_student.course_names.length != 0
            puts "\nYou are currently enrolled in:"
            puts @@user_student.course_names
            puts "\nType the name of the course you would like to drop:"
            print "⚡️ "
            to_delete = gets.chomp.strip
            # parsed_to_delete = valid_course(to_delete, @@user_student.course_names)
            # binding.pry
            # clean this input: it must be a valid course name
            course_to_delete = Course.find_by(name: to_delete, student_id: @@user_student.id)
            # binding.pry
            if course_to_delete
                @@user_student.drop_course(course_to_delete)
                puts "\nYou've successfully dropped #{course_to_delete.name} from your schedule."
            else
                puts "\nSorry, we couldn't find that course in your schedule."
                #maybe add functionality to have them try again
            end
        else
            puts "\nLooks like you don't have any courses for this semester yet!"
        end
        student_menu
    end

    def render_secret_orgs
        puts "\nPlease select a secret organization (number):\n"
        puts "1. Dumbledore's Army"
        puts "2. Order of the Phoenix\n"
        print "⚡️ "
        org = gets.chomp.strip
        parsed_org = valid_option(org, 2)

        case parsed_org
        when "1"
            org_helper("Dumbledore's Army", @@user_student.dumbledores_army)
        when "2"
            org_helper("Order of the Phoenix", @@user_student.order_of_the_phoenix)
        end
        student_menu
    end

    def render_drop_out
        puts "\nAre you sure you want to drop out of Hogwarts? (Y/N)"
        print "⚡️ "
        answer = gets.chomp.strip
        parsed_answer = valid_input(answer)
        case parsed_answer
        when "Y"
            @@user_student.get_expelled
            puts "\nHave a nice life\n\n"
            pid = fork{ exec 'killall', "afplay" }
            exit
        when "N"
        end
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
                puts "\nPlease enter a valid option number between 1 and #{num_options}:"
                print "⚡️ "
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
                puts "\nPlease enter a valid course from #{course_list}:"
                print "⚡️ "
                input = gets.chomp.strip
            end
        end
        input
    end

    # Determines if an input listing is valid based on a chomped input and Y / N
    def valid_input(input)
        valid = false

        while valid == false
            #accepts uppercase or lowercase Y/N
            if input.upcase == "Y" || input.upcase =="N"
                valid = true
            else
                puts "\nPlease enter Y or N:\n"
                print "⚡️ "
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
        puts "\nYou #{status} currently a member of #{org_name}. Would you like to #{change}? (Y/N)"
        print "⚡️ "
        answer = gets.chomp.strip
        parsed_answer = valid_input(answer)

        case parsed_answer
        when "Y"
            @@user_student.update_org(org_name, !joined)
            puts "\nYou've #{changed} #{org_name}."
        when "N"
        end
    end

    def ascii_art
        puts <<-'EOF'
                                         _ __
        ___                             | '  \
   ___  \ /  ___         ,'\_           | .-. \        /|
   \ /  | |,'__ \  ,'\_  |   \          | | | |      ,' |_   /|
 _ | |  | |\/  \ \ |   \ | |\_|    _    | |_| |   _ '-. .-',' |_   _
// | |  | |____| | | |\_|| |__    //    |     | ,'_`. | | '-. .-',' `. ,'\_
\\_| |_,' .-, _  | | |   | |\ \  //    .| |\_/ | / \ || |   | | / |\  \|   \
 `-. .-'| |/ / | | | |   | | \ \//     |  |    | | | || |   | | | |_\ || |\_|
   | |  | || \_| | | |   /_\  \ /      | |`    | | | || |   | | | .---'| |
   | |  | |\___,_\ /_\ _      //       | |     | \_/ || |   | | | |  /\| |
   /_\  | |           //_____//       .||`      `._,' | |   | | \ `-' /| |
        /_\           `------'        \ |              `.\  | |  `._,' /_\
                                       \|                    `.\
        EOF
    end

end