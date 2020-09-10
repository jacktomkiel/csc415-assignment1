# Jack Tomkiel - Assignment 1

require 'csv'

puts "-----------------------------------------------------------------"
puts "Welcome to the course management system!"
puts "-----------------------------------------------------------------"
puts "Enter the name of the file that you wish to read:"
puts "-----------------------------------------------------------------"
    selectedFile = gets.chomp
puts "-----------------------------------------------------------------"
puts "The file to be read is \"#{selectedFile}\" (y/n)?"
puts "-----------------------------------------------------------------"
    temp = gets.chomp
    if  temp == "y"
        puts "-----------------------------------------------------------------"
        puts "Opening file, please wait..."
        puts "-----------------------------------------------------------------"
    else
        puts "-----------------------------------------------------------------"
        puts "Exiting program ..."
        puts "-----------------------------------------------------------------"
        abort
    end

studentArray = CSV.read("#{selectedFile}", :headers => true)
puts "There are #{studentArray.size} students in this course"
puts "The Course roster is listed below"
puts "-----------------------------------------------------------------"
puts studentArray




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





