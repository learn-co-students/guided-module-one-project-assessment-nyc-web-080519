require 'text-table'

class CommandLineInterface

    #creates a class variable that will store our student instance
    @@user_student

    def runner
        system "clear"
        pid = fork{ exec 'afplay', "Harry_Potter_Theme_Song_Hedwigs_Theme.mp3" }
        puts "\n\n"
        ascii_art
        puts "\n\nWelcome to Hogwarts School of Witchcraft and Wizardry!\n"
        system "say 'Welcome to Hogwarts School of Witchcraft and Wizardry'"
        greet
        sleep(1)
        main_menu
    end

    def greet
        puts "\nWhat is your name?"
        print "⚡️ "
        name = gets.chomp.strip
        system "clear"

        #makes name field required, and will prompt again if you just hit enter
        until name != ""
            puts "\nWhat is your name?"
            print "⚡️ "
            name = gets.chomp.strip
            system "clear"
        end

        puts "\nAre you a returning student? (Y/N)"
        print "⚡️ "
        returning_student = gets.chomp.strip
        system "clear"
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
            sleep(2)
            puts "\nSorry, we can't find you."
            create_student(name)
        end
        
    end

    def create_student(name)
        puts "\nDo you want to create a new student? (Y/N)"
        print "⚡️ "
        answer = gets.chomp.strip
        system "clear"
        parsed_answer = valid_input(answer)

        sorting_hat_song = [
            "Oh, you may not think I’m pretty,",
            "But don’t judge on what you see,",
            "I’ll eat myself if you can find",
            "A smarter hat than me.",
            "You can keep your bowlers black,",
            "Your top hats sleek and tall,",
            "For I’m the Hogwarts Sorting Hat",
            "And I can cap them all.",
            "There’s nothing hidden in your head",
            "The Sorting Hat can’t see,",
            "So try me on and I will tell you",
            "Where you ought to be.",
            "You might belong in Gryffindor,",
            "Where dwell the brave at heart,",
            "Their daring, nerve and chivalry",
            "Set Gryffindors apart;",
            "You might belong in Hufflepuff,",
            "Where they are just and loyal,",
            "Those patient Hufflepuffs are true",
            "And unafraid of toil;",
            "Or yet in wise old Ravenclaw,",
            "If you’ve a ready mind,",
            "Where those of wit and learning,",
            "Will always find their kind;",
            "Or perhaps in Slytherin",
            "You’ll make your real friends,",
            "Those cunning folk use any means",
            "To achieve their ends.",
            "So put me on! Don’t be afraid!",
            "And don’t get in a flap!",
            "You’re in safe hands though I have none",
            "For I’m a Thinking Cap!"
        ]
        if parsed_answer == "Y"         #call make a new student
            puts "\n"
            sorting_hat_song.each do |line|
                puts line
                # system "say #{line}"
                sleep(0.5)
            end
            puts "\nHmmm, very interesting"
            house = House.all.sample
            sleep(3)
            puts "\n#{house.name}!"
            @@user_student = Student.create(name: name, dumbledores_army: false, order_of_the_phoenix: false, house_id: house.id)
            sleep(2)
            puts "\nYer a wizard, #{name}!\n"
        else
            puts "\nMaybe next year!\n\n"
            pid = fork{ exec 'killall', "afplay" }
            exit                        #exit
        end
    end



    #__________________________________________________________
    #   MENU MAIN

    def main_menu
        render_main_menu
        print "⚡️ "
        option = gets.chomp.strip
        system "clear"
        parsed_option = valid_option(option, 5)

        case parsed_option
        when "1"
            student_menu
        when "2"
            course_menu
        when "3"
            professor_menu
        when "4"
            house_menu
        when "5"
            puts "\nSee you next year!\n\n"
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
        system "clear"
        parsed_option = valid_option(option, 12)
    
        case parsed_option
        when "1"
            render_my_courses
        when "2"
            render_my_profs
        when "3"
            render_my_classmates
        when "4"
            render_all_students
        when "5"
            render_is_classmate
        when "6"
            render_add_course
        when "7"
            render_drop_course
        when "8"
            render_students_in_orgs
        when "9"
            render_secret_orgs
        when "10"
            render_my_housemates
        when "11"
            render_drop_out
        when "12"
            main_menu
        end
    end


    #-----------------------------------------------    
    # COURSE MENU


    def course_menu
        render_course_menu
        print "⚡️ "
        option = gets.chomp.strip
        system "clear"
        parsed_option = valid_option(option, 6)

        case parsed_option
        when "1"
            render_all_courses
        when "2"
            render_most_popular_course
        when "3"
            render_least_popular_course
        when "4"
            render_course_by_size
        when "5"
            render_course_by_subject
        when "6"
            main_menu
        end
    end

    #-----------------------------------------------    
    # PROFESSOR MENU


    def professor_menu
        render_prof_menu
        print "⚡️ "
        option = gets.chomp.strip
        system "clear"
        parsed_option = valid_option(option, 6)

        case parsed_option
        when "1"
            render_all_professors
        when "2"
            render_most_popular_prof
        when "3"
            render_prof_by_subject
        when "4"
            render_courses_by_prof
        when "5"
            render_students_by_prof
        when "6"
            main_menu
        end
    end

    #-----------------------------------------------    
    # HOUSE MENU
    
    def house_menu
        render_house_menu
        print "⚡️ "
        option = gets.chomp.strip
        system "clear"
        parsed_option = valid_option(option, 5)

        case parsed_option
        when "1"
            render_all_houses
        when "2"
            render_students_by_house
        when "3"
            render_highest_pop_house
        when "4"
            render_lowest_pop_house
        when "5"
            main_menu
        end
    end

    #-----------------------------------------------    
    # RENDER MENUS

    def render_main_menu
        puts "\nMain Menu"
        puts "-------------------------"
        puts "Please select an option:"
        puts "1. Student Portal"
        puts "2. General Course Data"
        puts "3. Professor Information"
        puts "4. House Facts"
        puts "5. Exit"
    end

    def render_student_menu
        puts "\nStudent Menu"
        puts "-------------------------"
        puts "Please select an option:"
        puts "1. See all of my courses"
        puts "2. See all of my professors"
        puts "3. See all of my classmates"
        puts "4. See all students"
        puts "5. See if a student is my classmate"
        puts "6. Add a course"
        puts "7. Drop a course"
        puts "8. See all students in a secret organization"
        puts "9. Join or leave a secret organization"
        puts "10. See all of my housemates"
        puts "11. Drop out of Hogwarts"
        puts "12. Back to main menu"
    end

    def render_course_menu
        puts "\nCourse Menu"
        puts "-------------------------"
        puts "Please select an option:"
        puts "1. See all courses"
        puts "2. See most popular course"
        puts "3. See least popular course"
        puts "4. Find courses by size"
        puts "5. Find courses by subject"
        puts "6. Back to main menu"
    end

    def render_prof_menu
        puts "\nProfessor Menu"
        puts "-------------------------"
        puts "Please select an option:"
        puts "1. See all professors"
        puts "2. See most popular professor"
        puts "3. Find professors by subject"
        puts "4. Find courses by professor"
        puts "5. Find students by professor"
        puts "6. Back to main menu"
    end

    def render_house_menu
        puts "\nHouse Menu"
        puts "-------------------------"
        puts "Please select an option:"
        puts "1. See all houses"
        puts "2. See students by house"
        puts "3. See house with most students"
        puts "4. See house with least students"
        puts "5. Back to main menu"
    end

    #----------------------------------------------------
    #       RENDER STUDENT METHODS

    def render_my_courses
        if @@user_student.course_names.count == 0
            puts "\nLooks like you don't have any courses for this semester yet!"
        else
            puts "\nYou are currently enrolled in:"
            puts @@user_student.course_names
        end
        sleep(2)
        student_menu
    end

    def render_my_profs
        if @@user_student.prof_names.count == 0
            puts "\nLooks like you don't have any courses for this semester yet!"
        else
            puts "\nYour professors are:"
            puts @@user_student.prof_names
        end
        sleep(2)
        student_menu
    end

    def render_my_classmates
        if @@user_student.my_classmates.count == 0
            puts "\nLooks like you don't have any courses for this semester yet!"
        else
            puts "\nYour classmates are:"
            puts @@user_student.my_classmates
        end
        sleep(2)
        student_menu
    end

    def render_all_students
        puts "\nHere are all students enrolled at Hogwarts:"
        puts Student.names
        sleep(2)
        student_menu
    end

    def render_is_classmate
        puts "\nWhich student?"
        print "⚡️ "
        input = gets.chomp.strip
        system "clear"
        if Student.find_by(name: input) && @@user_student.is_classmate?(input)
            puts "\nYes! #{input} is in at least one of your courses."
        elsif Student.find_by(name: input)
            puts "\nNo, #{input} isn't in any of your courses."
        else
            puts "\nSorry, we can't find that student."
        end
        sleep(2)
        student_menu
    end


    def render_add_course
        puts "\nPlease select a course (number):"
        Course.render_listings.each_with_index do |listing, i|
            puts "#{i+1}. #{listing}"
        end

        print "⚡️ "
        course_num = gets.chomp.strip.to_i
        system "clear"
        parsed_course_num = valid_option(course_num, Course.listings.length).to_i
        
        added = @@user_student.add_course(parsed_course_num)
        if added
            puts "\nYou've been added to #{Course.listings[parsed_course_num-1][0]}."
        end
        sleep(2)
        student_menu
    end

    def render_drop_course
        if @@user_student.course_names.length != 0
            puts "\nYou are currently enrolled in:"
            puts @@user_student.course_names
            puts "\nType the name of the course you would like to drop:"
            print "⚡️ "
            to_delete = gets.chomp.strip
            system "clear"
            course_to_delete = Course.find_by(name: to_delete, student_id: @@user_student.id)
            if course_to_delete
                @@user_student.drop_course(course_to_delete)
                puts "\nYou've successfully dropped #{course_to_delete.name} from your schedule."
            else
                puts "\nSorry, we couldn't find that course in your schedule."
            end
        else
            puts "\nLooks like you don't have any courses for this semester yet!"
        end
        sleep(2)
        student_menu
    end

    def render_students_in_orgs
        puts "\nPlease select a secret organization (number):\n"
        puts "1. Dumbledore's Army"
        puts "2. Order of the Phoenix\n"
        print "⚡️ "
        org = gets.chomp.strip
        system "clear"
        parsed_org = valid_option(org, 2)

        case parsed_org
        when "1"
            puts "\nThese are the students in Dumbledore's Army:"
            puts Student.da_members
        when "2"
            puts "\nThese are the students in Order of the Phoenix:"
            puts Student.op_members
        end
        sleep(2)
        student_menu
    end

    def render_secret_orgs
        puts "\nPlease select a secret organization (number):\n"
        puts "1. Dumbledore's Army"
        puts "2. Order of the Phoenix\n"
        print "⚡️ "
        org = gets.chomp.strip
        system "clear"
        parsed_org = valid_option(org, 2)

        case parsed_org
        when "1"
            org_helper("Dumbledore's Army", @@user_student.dumbledores_army)
        when "2"
            org_helper("Order of the Phoenix", @@user_student.order_of_the_phoenix)
        end
        sleep(2)
        student_menu
    end

    def render_my_housemates
        puts "\nYour housemates are:"
        puts @@user_student.house_mates
        sleep(2)
        student_menu
    end

    def render_drop_out
        puts "\nAre you sure you want to drop out of Hogwarts? (Y/N)"
        print "⚡️ "
        answer = gets.chomp.strip
        system "clear"
        parsed_answer = valid_input(answer)
        case parsed_answer
        when "Y"
            @@user_student.get_expelled
            puts "\nHave a nice muggle life.\n\n"
            pid = fork{ exec 'killall', "afplay" }
            exit
        when "N"
        end
        sleep(2)
        student_menu
    end

    #----------------------------------------------------------
    #   RENDER COURSE METHODS

    def render_all_courses
        puts "\nHere are all courses available at Hogwarts:"
        Course.render_listings.each_with_index do |listing, i|
            puts "#{i+1}. #{listing}"
        end
        sleep(2)
        course_menu
    end

    def render_most_popular_course
        puts "\nThe most popular course at Hogwarts this year is #{Course.most_popular}"
        sleep(2)
        course_menu
    end

    def render_least_popular_course
        puts "\nThe least popular course at Hogwarts this year is #{Course.least_popular}"
        sleep(2)
        course_menu
    end

    def render_course_by_size
        puts "\nHogwarts has a maximum number of students per course of 50.\nPlease enter a maximum course size for your search:"
        print "⚡️ "
        size = gets.chomp.strip
        system "clear"
        parsed_size = valid_option(size, 50).to_i

        if Course.find_by_size(parsed_size).empty?
            puts "\nThere are no courses that fit that criteria."
        else
            puts "\nHere are the courses with a maximum size of #{parsed_size}:"
            puts Course.find_by_size(parsed_size)
        end
        sleep(2)
        course_menu
    end


    def render_course_by_subject
        puts "\nPlease enter a subject for your search:"
        print "⚡️ "
        subject = gets.chomp.strip
        system "clear"

        if Course.find_by_subject(subject).empty?
            puts "\nSorry, we don't cover that subject matter."
        else
            puts "\nHere are the courses within #{subject}:"
            puts Course.find_by_subject(subject)
        end
        sleep(2)
        course_menu
    end

    #------------------------------------------------------
    # RENDER PROFESSOR METHODS

    def render_all_professors
        puts "\nHere is a list of professors at Hogwarts:"
        puts Professor.names
        sleep(2)
        professor_menu
    end

    def render_most_popular_prof
        puts "\nThe most popular professor at Hogwarts this year is #{Professor.most_popular_prof}."
        sleep(2)
        professor_menu
    end

    def render_prof_by_subject
        puts "\nPlease enter a subject for your search:"
        print "⚡️ "
        subject = gets.chomp.strip
        system "clear"

        if Course.prof_by_subject(subject).empty?
            puts "\nSorry, we don't have any professors that teach that at Hogwarts."
        else
            puts "\nHere are the #{subject} professors:"
            puts Course.prof_by_subject(subject)
        end
        sleep(2)
        professor_menu
    end

    def render_courses_by_prof
        puts "\nPlease enter a professor for your search:"
        print "⚡️ "
        prof_name = gets.chomp.strip
        system "clear"

        professor_obj = Professor.find_by(name: prof_name)

        if professor_obj
            puts "\nHere are #{professor_obj.name}'s courses:"
            puts Professor.course_names(professor_obj)
        else
            puts "\nSorry, that professor doesn't teach any courses at Hogwarts."
        end
        sleep(2)
        professor_menu
    end

    def render_students_by_prof
        puts "\nPlease enter a professor for your search:"
        print "⚡️ "
        prof_name = gets.chomp.strip
        system "clear"

        professor_obj = Professor.find_by(name: prof_name)

        if professor_obj
            puts "\nHere are #{professor_obj.name}'s students:"
            puts Professor.student_names(professor_obj)
        else
            puts "\nSorry, that professor doesn't have any students at Hogwarts."
        end
        sleep(2)
        professor_menu
    end

    #--------------------------------------------------------
    # RENDER HOUSE METHODS

    def render_all_houses
        table = Text::Table.new
        table.head = ['Name', 'Colors', 'Values', 'Mascot', 'Ghost', 'Founder']
        table.rows = []
        House.all.each do |house|
            table.rows << ["#{house.name}", "#{house.colors}", "#{house.values}", "#{house.mascot}", "#{house.house_ghost}", "#{house.founder}"]
            if house != House.all.last
                table.rows << :separator
            end
        end
        puts "\n"
        puts table.to_s

        sleep(2)
        house_menu
    end

    def render_students_by_house
        puts "\nPlease enter a house for your search:"
        print "⚡️ "
        house_name = gets.chomp.strip
        system "clear"

        house_obj = House.find_by(name: house_name)
        if house_obj
            puts "\nHere are the students in #{house_obj.name}:"
            puts house_obj.student_names
        else
            puts "\nSorry, that house doesn't exist at Hogwarts."
        end
        sleep(2)
        house_menu
    end

    # def render_house_bio
    #     puts "\nPlease enter a house to see more information:"
    #     print "⚡️ "
    #     house_name = gets.chomp.strip
    #     system "clear"

    #     house_obj = House.find_by(name: house_name)
    #     if house_obj
    #         puts "\nName: #{house_obj.name}"
    #         puts "Colors: #{house_obj.colors}"
    #         puts "Values: #{house_obj.values}"
    #         puts "Mascot: #{house_obj.mascot}"
    #         puts "Ghost: #{house_obj.house_ghost}"
    #         puts "Founder: #{house_obj.founder}"
    #     else
    #         puts "\nSorry, that house doesn't exist at Hogwarts."
    #     end
    #     sleep(2)
    #     house_menu
    # end

    def render_highest_pop_house
        puts "\nThe house with the most students at Hogwarts this year is #{House.most_popular}."
        sleep(2)
        house_menu
    end

    def render_lowest_pop_house
        puts "\nThe house with the least students at Hogwarts this year is #{House.least_popular}."
        sleep(2)
        house_menu
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
                system "clear"
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
                system "clear"
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
        system "clear"
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