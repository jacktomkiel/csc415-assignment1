# Jack Tomkiel - Assignment 1

# Welcome the user and prompt for input
puts "-----------------------------------------------------------------"
puts "Welcome to the course management system!"
puts "Enter the name of the file that you wish to open:"
puts "-----------------------------------------------------------------"

# Getting user input
file_to_open = gets.chomp

# Tempory code for debugging so file is always the same
if file_to_open != "textfile.txt" 
  file_to_open = "textfile.txt"
end

numLines = 0

# Show user the selected file, confirm y/n
puts "-----------------------------------------------------------------"
puts "The file selected text file is " + file_to_open
puts "Would you like to open this file? (y/n)"
openFile = gets.chomp
  if openFile == "y"
    puts "Opening file, please wait..."
    puts "-----------------------------------------------------------------"
      file = File.open("#{file_to_open}")
      for line in file.readlines()
        numLines += 1
        puts line
      end
    else
      puts "exiting program ..."
      file.close
      abort
  end

numStudents = numLines - 1

puts "-----------------------------------------------------------------"
puts "The number of lines is: " + numLines.to_s
puts "The number of Students is: " + numStudents.to_s
puts "-----------------------------------------------------------------"

studentArray = Array[numLines]
tempArray = Array.new[9]


i = 0
file.read.each_line do |line|
  tempArray = line.split(",")
  studentArray[i] = tempArray
  i += 1
end

puts studentArray.size
#puts "#{studentArray}"
puts studentArray.inspect



