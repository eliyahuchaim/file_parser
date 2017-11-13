require "./person"
require "./parse"
require 'Date'
require 'pry'

class Output

  @@all = Person.all
  @@test = []

  def self.create_people_data
    Parse.parse_csv File.read("data/comma_delimited.txt")
    Parse.parse_space_delimited File.read("data/space_delimited.txt")
    Parse.parse_pipe_delimited File.read("data/pipe_delimited.txt")
  end

  def self.all
    @@all
  end

  def self.test
    @@test
  end

  def self.sort_by_gender_and_lastname
    females = []
    males = []

    self.all.each do |person|
      if person.gender == "Female"
        females << person
      elsif person.gender == "Male"
        males << person
      end
    end

    females.sort! { |a, b| a.lastname <=> b.lastname }
    males.sort! { |a, b| a.lastname <=> b.lastname }

    females.concat(males)
  end


  def self.sort_by_birthday
    self.all.sort do |a, b|
      Date.strptime(a.birthday, "%m/%d/%Y") <=> Date.strptime(b.birthday, "%m/%d/%Y")
    end
  end

  def self.sort_by_lastname
    self.all.sort {|a,b| b.lastname <=> a.lastname }
  end

  def self.main_output
    self.create_people_data

    puts "output 1 - sorted by gender and last name ascending
    \n"
    self.sort_by_gender_and_lastname.each do |person|
      puts person.print_person
    end

    puts "\noutput 2 - sorted by birth date, ascending
    \n"
    self.sort_by_birthday.each do |person|
      puts person.print_person
    end

    puts "\noutput 3 - sorted by last name, descending
    \n"
    self.sort_by_lastname.each do |person|
      puts person.print_person
    end


  end



end

Output.main_output
