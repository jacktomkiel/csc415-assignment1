# Jack Tomkiel - Assignment 1
require 'csv'

class ManagementSystem

    # initializing instance variables
    def initialize
        @student_array = []
        @file_loaded = false
        @group_array = []
        @HEADERS = ['first_name','last_name','email','section','major1','major2','minor1','minor2']
        @dash = "-"*40
        @console_headers = "First Name".ljust(20) + "Last Name".ljust(20) + "Email".ljust(35) + "Section".ljust(10) + "Major 1".ljust(35) + "Major 2 (optional)".ljust(35) + "Minor 1 (optional)".ljust(35) + "Minor 2 (optional)".ljust(35)
    end

    # displays the main user menu used in this program
    def user_menu
        puts "1-input data from file"
        puts "2-edit data"
        puts "3-form groups"
        puts "4-list groups"
        puts "5-write groups to file"
        puts "6-view course information"
        puts "0-exit the program"  
        user_selection = gets.chomp
            # case statement calls respective methods based on user's selection.
            # gives error if file is not loaded and returns to menu
            case user_selection
                when "0"
                    abort
                when "1"
                    input_data
                when "2"
                    if @file_loaded
                        edit_data
                    else
                        puts @dash+"error-file-not-loaded"+@dash
                        user_menu
                    end 
                when "3"
                    if @file_loaded
                        form_groups
                    else
                        puts @dash+"error-file-not-loaded"+@dash
                        user_menu
                    end 
                when "4"
                    if @file_loaded
                        list_groups
                    else
                        puts @dash+"error-file-not-loaded"+@dash
                        user_menu
                    end 
                when "5"
                    if @file_loaded
                        write_groups
                    else
                        puts @dash+"error-file-not-loaded"+@dash
                        user_menu
                    end 
                when "6"
                    if @file_loaded
                        list_course_info
                    else
                        puts @dash+"error-file-not-loaded"+@dash
                        user_menu
                    end 
                else
                    puts @dash+"error-invalid-selection"+@dash
                    user_menu
            end
    end

    # prompts user for the file they would like to input, loads file into @student_array as an array of hashes
    def input_data
        puts "Enter the name of the file that you wish to read:"
            selected_file = gets.chomp
        puts "The file to be read is \"#{selected_file}\" (y/n)?"
        user_input = gets.chomp
        # checking to make sure user is loading the correct file   
        if  user_input == "y"
            begin
            # Using CSV class, the selected file is read into @students_array as an array of hashes. Appropriate converters are used to handle optional fields
            @student_array = CSV.read(selected_file, headers: true, header_converters: :symbol, :converters => :all).map(&:to_hash)
            puts "File Loaded...Returning to menu"
            @file_loaded = true
            user_menu
            rescue
                # if the file is not found, and code produces an exception, it is caught, an error is printed, and user returns to menu
                puts @dash+"error-file-not-found"+@dash
                user_menu
            end
        # If user selects 'n' this returns the user to the main user menu
        else
            puts "Returning to menu..."
            user_menu
        end
    end

    # lists the current course information
    def list_course_info
        puts "There are #{@student_array.length} students in this course"
        puts "The Course roster is listed below"
        # the code below neatly prints the contents of @student_array, making use of ruby's .ljust method
        puts @console_headers
        @student_array.each do |student|
                puts student[:first_name].ljust(20) + student[:last_name].ljust(20) +
                student[:email].ljust(35) + student[:section].to_s.ljust(10) +
                student[:major1].ljust(35) + student[:major2].to_s.ljust(35) +
                student[:minor1].to_s.ljust(35) + student[:minor2].to_s.ljust(35)
        end
            # in case of extremely large file, prints course information at bottom of file so need not scroll up
            if @student_array.length > 40
                puts "The Course roster is listed above"
                puts "There are #{@student_array.length} students in this course"
            end
        # Prompts the user to return to menu
        puts "Press 'enter' to return to menu"
        temp = gets.chomp
        user_menu
    end

    # neatly prints the contents of the @group_array and adds relavant group label to console output
    def list_groups
        @group_array.each_with_index do |group, index|
            puts "Group " + (index + 1).to_s
            puts @console_headers
            group.each do |student|
                puts student[:first_name].ljust(20) + student[:last_name].ljust(20) +
                student[:email].ljust(35) + student[:section].to_s.ljust(10) +
                student[:major1].ljust(35) + student[:major2].to_s.ljust(35).to_s +
                student[:minor1].to_s.ljust(35) + student[:minor2].to_s.ljust(35)
            end
        end
        # Prompts the user to return to menu
        puts "Press 'enter' to return to menu"
        temp = gets.chomp
        user_menu
    end

    # Edits student data, called by user_menu, case statement calls relevant method for each action
    def edit_data
        puts "1-add student"
        puts "2-delete student"
        puts "3-edit student data"
        user_selection = gets.chomp
            case user_selection
            when "1"
                add_student
            when "2"
                delete_student
            when "3"
                edit_student_data
            else
                puts @dash+"error-invalid-selection"+@dash
                user_menu
            end
    end

    # adds a student to the @student_array
    def add_student
        puts "Enter first_name:"
        first_name = gets.chomp
        puts "Enter last_name:"
        last_name = gets.chomp
        puts "Enter email:"
        email = gets.chomp
        puts "Enter section:"
        section = gets.chomp
        puts "Enter major1:"
        major1 = gets.chomp
        puts "Enter major2: *optional, press enter to leave blank*"
        major2 = gets.chomp
        puts "Enter minor1: *optional, press enter to leave blank*"
        minor1 = gets.chomp
        puts "Enter minor2: *optional, press enter to leave blank*"
        minor2 = gets.chomp
        # pushes in the new students (key, value) pairs into the @student array
        @student_array.push({:first_name=>first_name, :last_name=>last_name, :email=>email, :section=>section, :major1=>major1, :major2=>major2, :minor1=>minor1, :minor2=>minor2})
        user_menu
    end

    # deletes a student from the @student_array
    def delete_student
        # searches for the student via email (unique identifier)
        puts "Enter the email of the student you would like to remove:"
        student_email = gets.chomp
        student_found = false
            # for each student in @student_array, we check if their email matches, if yes, student is deleted and searching stops
            @student_array.each_with_index do |student, index|
                if @student_array[index][:email] == student_email
                    student_found = true
                    @student_array.delete_at(index)
                    puts "Student removed"
                    break
                end
            end
            # if student is not found, prints message and returns to menu
            if !student_found
                puts "Student not found"
            end
            user_menu
    end

    # edits a student's data 
    def edit_student_data
        puts "Enter the email of the student you would like to edit:"
            student_email = gets.chomp
            student_found = false
                # searches the same way as delete_student method, then sets student data based off user input
                @student_array.each_with_index do |student, index|
                    if @student_array[index][:email] == student_email
                        student_found = true
                        puts "Enter first_name: (required)"
                        first_name = gets.chomp
                        @student_array[index][:first_name] = first_name
                        puts "Enter last_name: (required)"
                        last_name = gets.chomp
                        @student_array[index][:last_name] = last_name
                        puts "Enter email: (required)"
                        email = gets.chomp
                        @student_array[index][:email] = email
                        puts "Enter section: (required)"
                        section = gets.chomp
                        @student_array[index][:section] = section
                        puts "Enter major1: (required)"
                        major1 = gets.chomp
                        @student_array[index][:major1] = major1
                        puts "Enter major2:"
                        major2 = gets.chomp
                        @student_array[index][:major2] = major2
                        puts "Enter minor1:"
                        minor1 = gets.chomp
                        @student_array[index][:minor1] = minor1
                        puts "Enter minor2:"
                        minor2 = gets.chomp
                        @student_array[index][:minor2] = minor2
                        puts @dash+"Student edited"+@dash
                    end
                end
            # if student is not found, return to menu
            if !student_found
                puts @dash+"student-not-found"+@dash
            end
        user_menu  
    end

    # used for forming groups, this method is a bubble sort algorithm modified to work an array of hashes and sort by :section (integer)
    def bubble_sort_section(array)
        n = array.length
        swapped = true
        while swapped do
          swapped = false
          (n - 1).times do |i|
            # here, each index is compared to the next index, and swaps them if the current is greater than the next
            if array[i][:section] > array[i + 1][:section]
              array[i], array[i + 1] = array[i + 1], array[i]
          swapped = true
            end
          end
        end
        array 
     end

     # used for forming groups, this method is a bubble sort algorithm modified to work an array of hashes and sort by :major (string)
     def bubble_sort_major(array)
        n = array.length
        swapped = true
        while swapped do
          swapped = false
          (n - 1).times do |i|
            # here, the string at each index are compared to the next, and they are swapped if the current is greater than the next
            if (array[i][:major1] <=> array[i + 1][:major1]) > 0
              array[i], array[i + 1] = array[i + 1], array[i]
          swapped = true
            end
          end
        end
        array 
     end    

    # forms students into groups based on specified constraints
    def form_groups
        # allows for the user to sort randomly, by section, by major, by section major, and asks users for desired number of students per group
        puts "Enter how you would like groups to sorted, then choose the number of students in each group"
            puts "1-sort groups randomly"
            puts "2-sort groups by section"
            puts "3-sort groups by major"
            puts "4-sort groups by section and major"
            user_selection = gets.chomp
            case user_selection
            when "1"
                    puts "Groups will be formed randomly and the student list will be permanantly sorted."
                    puts "Enter the number of students per group: "
                    num_students = gets.chomp.to_i
                    # uses ruby's .shuffle method to randomly place students in @student_array
                    @student_array = @student_array.shuffle
                    # the code below takes the num_students and splits the elements (students) in @student_array into @group_array with num_students each nested array (the groups)
                    # essentially, @student_array is 'chunked' into smaller pieces which become @group_array
                    @group_array = @student_array.each_slice(num_students).to_a
                    puts "There are #{@group_array.length} groups"
                    puts "Press 'enter' to return to menu"
                    temp = gets.chomp
                    user_menu
            when "2"
                    puts "Groups will be formed by section and the student list will be permanantly sorted."
                    puts "Enter the number of students per group: "
                    num_students = gets.chomp.to_i
                    # calls the bubble_sort_section method on @student_array, and then splits it into properly sized groups
                    @student_array = bubble_sort_section(@student_array)
                    @group_array = @student_array.each_slice(num_students).to_a
                    puts "There are #{@group_array.length} groups"
                    puts "Press 'enter' to return to menu"
                    temp = gets.chomp
                    user_menu
            when "3"
                    puts "Groups will be formed by major and the student list will be permanantly sorted."
                    puts "Enter the number of students per group: "
                    num_students = gets.chomp.to_i
                    # calls the bubble_sort_major method on @student_array, and then splits it into properly sized groups
                    @student_array = bubble_sort_major(@student_array)
                    @group_array = @student_array.each_slice(num_students).to_a
                    puts "There are #{@group_array.length} groups"
                    puts "Press 'enter' to return to menu"
                    temp = gets.chomp
                    user_menu
            when "4"
                puts "Groups will be formed by major and the student list will be permanantly sorted."
                puts "Enter the number of students per group: "
                num_students = gets.chomp.to_i
                # calls the bubble_sort_section method on @student_array, then the bubble_sort_major method and then splits it into properly sized groups
                # this sorts the @student_array by section, then major, so when groups are made the groups are sorted by section and major
                @student_array = bubble_sort_section(@student_array)
                @student_array = bubble_sort_major(@student_array)
                @group_array = @student_array.each_slice(num_students).to_a
                puts "There are #{@group_array.length} groups"
                puts "Press 'enter' to return to menu"
                temp = gets.chomp
                user_menu
            else
                puts @dash+"error-invalid-selection"+@dash
                user_menu
            end
    end

    def write_groups
        # writes group data to file using built in CSV methods, puts hash keys as file header
        CSV.open("tomkiel_groups_array.csv", "wb", :headers => @HEADERS, :write_headers => true) do |csv|
            @group_array.each do |group|
                csv << group
            end
        end
        puts "File saved"
        puts "Press 'enter' to return to menu"
        temp = gets.chomp
        user_menu
    end

end

# creates an instance of the course management system in which the program runs
puts "Welcome to the course management system!"
instance1 = ManagementSystem.new
    # calls user_menu, which starts the program
    instance1.user_menu
    











