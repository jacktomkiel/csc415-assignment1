# Jack Tomkiel - Assignment 1

require 'csv'

header = nil
students = []

CSV.foreach('textfile.txt') do |row|
    if header.nil?
        header = row
    else
        students << row
    end
end

early_students = students[0..9]

CSV.open('early_students.csv', 'w') do |csv|
    csv << header
    early_students.each do |row|
        csv << row
    end
end


