# Jack Tomkiel - Assignment 1
require 'csv'

class ManagementSystem

    # initializing class variables
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
            # case statement calls respective methods based on user's selection
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
                        # writes group data to file using built in CSV methods
                        CSV.open("groups_array.csv", "wb", :headers => @HEADERS, :write_headers => true) do |csv|
                            @group_array.each do |group|
                                csv << group
                            end
                        end
                        File.write("groups_array.csv", @group_array.map(&:to_csv).join)
                        puts @group_array.inspect
                        user_menu
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
            @student_array = CSV.read("#{selected_file}", headers: true, header_converters: :symbol, :converters => :all, nil_value: "").map(&:to_h)
            puts "File Loaded...Returning to menu"
            @file_loaded = true
            user_menu
            rescue
                puts @dash+"error-file-not-found"+@dash
            end
            user_menu
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
        puts @console_headers
        @student_array.each do |student|
                puts student[:first_name].ljust(20) + student[:last_name].ljust(20) +
                student[:email].ljust(35) + student[:section].to_s.ljust(10) +
                student[:major1].ljust(35) + student[:major2].ljust(35) +
                student[:minor1].ljust(35) + student[:minor2].ljust(35)
        end
            if @student_array.length > 40
                puts "The Course roster is listed above"
                puts "There are #{@student_array.length} students in this course"
            end
        puts "Press 'enter' to return to menu"
        temp = gets.chomp
        user_menu
    end

    def list_groups
        @group_array.each_with_index do |group, index|
            puts "Group " + (index + 1).to_s
            puts @console_headers
            group.each do |student|
                puts student[:first_name].ljust(20) + student[:last_name].ljust(20) +
                student[:email].ljust(35) + student[:section].to_s.ljust(10) +
                student[:major1].ljust(35) + student[:major2].ljust(35) +
                student[:minor1].ljust(35) + student[:minor2].ljust(35)
            end
        end
        puts "Press 'enter' to return to menu"
        temp = gets.chomp
        user_menu
    end

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
        puts "Enter major2:"
        major2 = gets.chomp
        puts "Enter minor1:"
        minor1 = gets.chomp
        puts "Enter minor2:"
        minor2 = gets.chomp
        @student_array.push({:first_name=>first_name, :last_name=>last_name, :email=>email, :section=>section, :major1=>major1, :major2=>major2, :minor1=>minor1, :minor2=>minor2})
        user_menu
    end

    def delete_student
        puts "Enter the email of the student you would like to remove:"
        student_email = gets.chomp
        student_found = false
            @student_array.each_with_index do |student, index|
                if @student_array[index][:email] == student_email
                    student_found = true
                    @student_array.delete_at(index)
                    puts "Student removed"
                    break
                end
            end
            if !student_found
                puts "Student not found"
            end
            user_menu
    end

    def edit_student_data
        puts "Enter the email of the student you would like to edit:"
            student_email = gets.chomp
            student_found = false
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
            if !student_found
                puts @dash+"student-not-found"+@dash
            end
        user_menu  
    end

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

    def form_groups
        puts "Enter how you would like groups to sorted, then choose the number of students in each group"
            puts "1-sort groups randomly"
            puts "2-sort groups by section"
            user_selection = gets.chomp.to_i
                if user_selection == 1
                    puts "Groups will be formed randomly and the student list will be permanantly sorted."
                    puts "Enter the number of students per group: "
                    num_groups = gets.chomp.to_i
                    @student_array = @student_array.shuffle
                    @group_array = @student_array.each_slice(num_groups).to_a
                    puts "There are #{@group_array.length} groups"
                    puts "Press 'enter' to return to menu"
                    temp = gets.chomp
                    user_menu
                elsif user_selection == 2
                    puts "Groups will be formed by section and the student list will be permanantly sorted."
                    puts "Enter the number of students per group: "
                    num_groups = gets.chomp.to_i
                    @student_array = bubble_sort_section(@student_array)
                    @group_array = @student_array.each_slice(num_groups).to_a
                    puts "There are #{@group_array.length} groups"
                    puts "Press 'enter' to return to menu"
                    temp = gets.chomp
                    user_menu
                else
                    puts @dash+"error-invalid-selection"+@dash
                    user_menu
                end
    end

    def bubble_sort_section(array)
        n = array.length
        swapped = true
        while swapped do
          swapped = false
          (n - 1).times do |i|
            if array[i][:section] > array[i + 1][:section]
              array[i], array[i + 1] = array[i + 1], array[i]
          swapped = true
            end
          end
        end
        array 
     end

end

puts "Welcome to the course management system!"
run = ManagementSystem.new
    run.user_menu
    












