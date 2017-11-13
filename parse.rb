require './person'
require 'pry'

class Parse

  def self.validate_gender gender
    if gender.strip == "M"
      "Male"
    elsif gender.strip == "F"
      "Female"
    else
      # gender is not valid so return false and do not create person
      false
    end
  end

  def self.validate_birthdate date
    date.gsub(/[-]/, '/')
  end

  def self.parse_csv data
    data = data.split("\n").map {|person| person.split(",")}

    for person in data
      Person.new(person[0].strip, person[1].strip, person[2].strip, person[4].strip, person[3].strip)
    end
  end

  def self.parse_space_delimited data
    data = data.split("\n").map {|person| person.split(" ")}

    for person in data
      gender = Parse.validate_gender person[3]
      birthday = Parse.validate_birthdate person[4]
      Person.new(person[0].strip, person[1].strip, gender, birthday, person[5].strip)
    end
  end

  def self.parse_pipe_delimited data
    data = data.split("\n").map {|person| person.split("|")}

    for person in data
      gender = Parse.validate_gender person[3]
      birthday = Parse.validate_birthdate person[5]
      Person.new(person[0].strip, person[1].strip, gender, birthday.strip, person[4].strip)
    end
  end



end

# Parse.parse_csv File.read("data/comma_delimited.txt")
# Parse.parse_space_delimited File.read("data/space_delimited.txt")
# Parse.parse_pipe_delimited File.read("data/pipe_delimited.txt")
#
#
# Person.all.each do |person|
#   puts person.puts_person
# end
