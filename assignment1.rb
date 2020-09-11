# Jack Tomkiel - Assignment 1
require 'csv'

class ManagementSystem

    def userMenu
        loop do
            puts "Welcome to the course management system!"
            puts "1-input data from file"
            puts "2-list course information"
            puts "3-edit data"
            puts "4-form groups"
            puts "5-list groups"
            puts "6-write groups to file"
            puts "0-exit the program"  

            userSelection = gets.chomp

            case userSelection
            when "0"
                abort
            when "1"
                inputData
            when "2"
                listCourseInfo
            when "3"
                # do this
            when "4"
                # do this
            when "5"
                # do this
            when "6"
                # do this
            else
                puts "\nerror - invalid selection\n\n"
            end
        end
    end

    def inputData
        puts "Enter the name of the file that you wish to read:"
        selectedFile = gets.chomp
        puts "The file to be read is \"#{selectedFile}\" (y/n)?"
        temp = gets.chomp
        if  temp == "y"
            puts "Opening file, please wait..."
        else
            puts "\nReturning to menu...\n\n"
            userMenu
            # puts "Exiting program ..."
            # abort
        end
        studentArray = CSV.read("#{selectedFile}", :headers => true)
        # puts "There are #{studentArray.size} students in this course"
        # puts "The Course roster is listed below"
        # puts studentArray
    end

    def listCourseInfo
        puts "There are #{studentArray.size} students in this course"
        puts "The Course roster is listed below"
        puts studentArray
    end

    @@userMenu

end













# desired_indices = [3, 4, 5].sort # these are rows you would like to modify
# studentArray.each.with_index(desired_indices[0]) do |row, index| 
#   if desired_indices.include?(index)

#     # modify over here
#     rows_array[index][target_column] = 'modification'

#   end
# end

# studentArray.each do |row1|
#     puts row1.inspect
# end




# File.write("test.txt", studentArray.map(&:to_csv).join)





