# Jack Tomkiel - Assignment 1
require 'csv'

class ManagementSystem

    def initialize
        @studentArray = []
        @selectedFile = ""
        @dash = "-"*40
    end

    def userMenu
            puts "Welcome to the course management system!"
            puts "1-input data from file"
            puts "2-edit data"
            puts "3-form groups"
            puts "4-list groups"
            puts "5-write groups to file"
            puts "6-view course information"
            puts "0-exit the program"  
            userSelection = gets.chomp
                case userSelection
                when "0"
                    abort
                when "1"
                    inputData
                when "2"
                    editData
                when "3"
                    formGroups
                when "4"
                    # do this
                when "5"
                    # do this
                when "6"
                    listCourseInfo
                else
                    puts @dash+"error-invalid-selection"+@dash
                    userMenu
                end
    end

    def inputData
        puts "Enter the name of the file that you wish to read:"
        @selectedFile = gets.chomp
        puts "The file to be read is \"#{@selectedFile}\" (y/n)?"
        temp = gets.chomp
        if  temp == "y"
            @studentArray = CSV.read("#{@selectedFile}", :headers => true)
            puts "File Loaded...Returning to menu"
            userMenu
        else
            puts "Returning to menu..."
            userMenu
        end
    end

    def listCourseInfo
        puts "There are #{@studentArray.length} students in this course"
        puts "The Course roster is listed below"
        puts @studentArray
        puts "Press 'enter' to return to menu"
        temp = gets.chomp
        userMenu
    end

    def editData
        puts "1-add student"
        puts "2-delete student"
        puts "3-edit student data"
        userSelection = gets.chomp
            case userSelection
            when "1"
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
                @studentArray.push([first_name,last_name,email,section,major1,major2,minor1,minor2])
                userMenu
            when "2"
                puts "Enter the email of the student you would like to remove:"
                studentEmail = gets.chomp
                studentFound = false
                puts @studentArray.length
                for i in 0..@studentArray.length-1
                    if @studentArray[i][2] == studentEmail
                        studentFound = true
                        @studentArray.delete(i)
                        puts "Student removed"
                    end
                end
                if !studentFound
                    puts "Student not found"
                end
                userMenu
            when "3"
                puts "Enter the number of the email of you would like to edit:"
                studentNumber = gets.chomp.to_i
                puts "Enter first_name:"
                first_name = gets.chomp
                @studentArray[studentNumber][0] = first_name
                puts "Enter last_name:"
                last_name = gets.chomp
                @studentArray[studentNumber][1] = last_name
                puts "Enter email:"
                email = gets.chomp
                @studentArray[studentNumber][2] = email
                puts "Enter section:"
                section = gets.chomp
                @studentArray[studentNumber][3] = section
                puts "Enter major1:"
                major1 = gets.chomp
                @studentArray[studentNumber][4] = major1
                puts "Enter major2:"
                major2 = gets.chomp
                @studentArray[studentNumber][5] = major2
                puts "Enter minor1:"
                minor1 = gets.chomp
                @studentArray[studentNumber][6] = minor1
                puts "Enter minor2:"
                minor2 = gets.chomp
                @studentArray[studentNumber][7] = minor2
                userMenu
            else
                puts @dash+"error-invalid-selection"+@dash
                userMenu
            end
    end

    def formGroups
        puts "Enter how many students per group:"
        numStudents = gets.chomp.to_i
        puts @studentArray.length
        numGroups = @studentArray.length / numStudents
        puts "The number of groups is: #{numGroups}"
    end

end

cm = ManagementSystem.new
cm.userMenu




# CSV.foreach("textfile.txt", headers: true) do |row|
#     puts row.inspect # hash
#   end

# CSV.parse("textfile.txt", headers: true).map(&:to_h)

# data_file = 'textfile.txt'
# data = []
# CSV.foreach(data_file, headers: true) do |row|
#   data << row.to_hash
# end
# puts "#{data[0]["first_name"]}"



# File.write("test.txt", @studentArray.map(&:to_csv).join)


# when "3"
#     puts "Enter the number of the email of you would like to edit:"
#     studentNumber = gets.chomp.to_i
#     puts "Enter first_name:"
#     first_name = gets.chomp
#     @studentArray[studentNumber][0] = first_name
#     puts "Enter last_name:"
#     last_name = gets.chomp
#     @studentArray[studentNumber][1] = last_name
#     puts "Enter email:"
#     email = gets.chomp
#     @studentArray[studentNumber][2] = email
#     puts "Enter section:"
#     section = gets.chomp
#     @studentArray[studentNumber][3] = section
#     puts "Enter major1:"
#     major1 = gets.chomp
#     @studentArray[studentNumber][4] = major1
#     puts "Enter major2:"
#     major2 = gets.chomp
#     @studentArray[studentNumber][5] = major2
#     puts "Enter minor1:"
#     minor1 = gets.chomp
#     @studentArray[studentNumber][6] = minor1
#     puts "Enter minor2:"
#     minor2 = gets.chomp
#     @studentArray[studentNumber][7] = minor2
#     userMenu