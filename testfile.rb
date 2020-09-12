# Jack Tomkiel - Assignment 1

# This file is to being used to explore the ruby language
# and learn how things work

require 'csv'

data = CSV.read('textfile.txt', :headers => true)

puts data.length
puts data[0][0]
puts "\n\n\n\n"


# working
for i in 0..data.length-1
    if data[i][2] == "Andrew"
        puts "found pedro"
    else
        puts "no tacos"
    end
end








# i=0
# puts students.size
# while i<=students.size
#     puts "loop #{i}"
#     if 
#         students[i][3] == students[i+1][3]
#     i +=1
# end





# CSV.foreach('textfile.txt', :headers => true) do |row1|
#     puts row1.inspect
#     end