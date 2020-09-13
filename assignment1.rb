# Jack Tomkiel - Assignment 1
require 'csv'

class ManagementSystem

    def initialize
        @student_array = []
        @group_array = []
        @selected_file = ""
        @dash = "-"*40
    end

    def user_menu
        puts "1-input data from file"
        puts "2-edit data"
        puts "3-form groups"
        puts "4-list groups"
        puts "5-write groups to file"
        puts "6-view course information"
        puts "0-exit the program"  
        user_selection = gets.chomp
            case user_selection
                when "0"
                    abort
                when "1"
                    input_data
                when "2"
                    edit_data
                when "3"
                    form_groups
                when "4"
                    # do this
                when "5"
                    File.write("groups_array.csv", @group_array.map(&:to_csv).join)
                when "6"
                    list_course_info
                else
                    puts @dash+"error-invalid-selection"+@dash
                    user_menu
            end
    end

    def input_data
        puts "Enter the name of the file that you wish to read:"
            @selected_file = gets.chomp
        puts "The file to be read is \"#{@selected_file}\" (y/n)?"
        user_input = gets.chomp
        if  user_input == "y"
            @student_array = CSV.read("#{@selected_file}", headers: true, header_converters: :symbol, :converters => :all).map(&:to_h)
            puts "File Loaded...Returning to menu"
            user_menu
        else
            puts "Returning to menu..."
            user_menu
        end
    end

    def list_course_info
        puts "There are #{@student_array.length} students in this course"
        puts "The Course roster is listed below"
        puts @student_array
        puts "Press 'enter' to return to menu"
        temp = gets.chomp
        user_menu
    end

    def list_groups
        @group_array.each do |group|
            group.each do |student|
                puts student[:first_name]
            end
        end
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
            for i in 0..@student_array.length()-1
                if @student_array[i][:email] == student_email
                    student_found = true
                    @student_array.delete_at(i)
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
                for i in 0..@student_array.length-1
                    if @student_array[i][:email] == student_email
                        student_found = true
                        puts "Enter first_name: (required)"
                        first_name = gets.chomp
                        @student_array[i][:first_name] = first_name
                        puts "Enter last_name: (required)"
                        last_name = gets.chomp
                        @student_array[i][:last_name] = last_name
                        puts "Enter email: (required)"
                        email = gets.chomp
                        @student_array[i][:email] = email
                        puts "Enter section: (required)"
                        section = gets.chomp
                        @student_array[i][:section] = section
                        puts "Enter major1: (required)"
                        major1 = gets.chomp
                        @student_array[i][:major1] = major1
                        puts "Enter major2:"
                        major2 = gets.chomp
                        @student_array[i][:major2] = major2
                        puts "Enter minor1:"
                        minor1 = gets.chomp
                        @student_array[i][:minor1] = minor1
                        puts "Enter minor2:"
                        minor2 = gets.chomp
                        @student_array[i][:minor2] = minor2
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
            end
    end

    def form_groups
        puts "Groups will be formed by section."
        puts "Enter the number of groups you wish to form: "
        num_groups = gets.chomp.to_i
        @group_array = @student_array.each_slice(num_groups).to_a
        user_menu
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
    












