# Jack Tomkiel - Assignment 1
# This file is to being used to explore the ruby language
# and learn how things work

require 'csv'
require 'enumerator'
groups = []

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

data = CSV.read('textfile.txt', headers: true, header_converters: :symbol, :converters => :all).map(&:to_h)

data = bubble_sort_section(data)

data.each do |student|
    puts student
end
puts ""

groups = data.each_slice(2).to_a



# num_groups = 2
# groups     = Array.new(num_groups){[]}
# wheel      = groups.cycle
# data.each{|h| wheel.next << h}

groups.each do |element|
    puts ""
    puts element
    puts ""
end



# data[0][:first_name] = "Jack"
# puts data[0][:first_name]

# sorted_data = data.sort_by { |hsh| hsh[:section]}

# puts sorted_data.inspect

# data.each do |element|
#     # puts element.inspect
#     element.each do |inner_element|
#         puts inner_element.inspect
#     end
# end



# ---
# yesterdays tests
# ---
# require 'csv'


# data = CSV.read('sample.csv', headers: true, header_converters: :symbol, :converters => :all).map(&:to_h)
# puts data.inspect
# puts data[0][:first_name]
# data[0][:first_name] = "Jack"
# puts data[0][:first_name]

# sorted_data = data.sort_by { |hsh| hsh[:section]}

# puts sorted_data.inspect

# data.each do |element|
#     # puts element.inspect
#     element.each do |inner_element|
#         puts inner_element.inspect
#     end
# end

# ---


# CSV.open('cats.csv', 'w', :write_headers => true)




# puts data[0][0]


# working
# data = CSV.read('textfile.txt', headers: true, header_converters: :symbol, :converters => :all).map(&:to_h)
# puts data.inspect  
# test = data[0][:first_name]
# puts test
# working


# data = CSV.read('textfile.txt', headers: true).map(&:to_h) MAGIC

# --------------------------
# data.each do |element|
#   puts element.inspect
# end



# working
# for i in 0..data.length-1
#     if data[i][2] == "Andrew"
#         puts "found pedro"
#     else
#         puts "no tacos"
#     end
# end



# puts "enter a number"
# number = gets.chomp.to_i
# if number > 5 || number <= 0
#     puts "failed"
# end
# puts "yes"





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