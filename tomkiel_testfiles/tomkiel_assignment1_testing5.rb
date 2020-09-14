require 'csv'

studentArray = CSV.read("textfile.txt", :headers => true)

# puts studentArray
puts studentArray
puts "\n\n\n"
studentArray[0][0] = "jack"




puts studentArray[0][]