require "./person"
require "./parse"
require 'Date'

class Output

  @@all = Person.all
  @@file = File.open("results.txt", "w") {|f| f.puts ("Results:")}

  def self.create_people_data_from_files
    Dir.entries("./data").each do |file|
      if file == "comma_delimited.txt"
        Parse.parse_csv File.read("data/#{file}")
      elsif file == "pipe_delimited.txt"
        Parse.parse_pipe_delimited File.read("data/#{file}")
      elsif file == "space_delimited.txt"
        Parse.parse_space_delimited File.read("data/#{file}")
      end
    end
  end


  def self.all
    @@all
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

  def self.write_sorted_by_gender_to_file
    File.open("results.txt", "a") {|f| f.puts("\nOutput 1:")}
    self.sort_by_gender_and_lastname.each do |person|
      File.open("results.txt", "a") {|f| f.puts(person.print_person)}
    end
  end

  def self.write_sorted_by_birthdate_to_file
    File.open("results.txt", "a") {|f| f.puts("\nOutput 2:")}
    self.sort_by_birthday.each do |person|
      File.open("results.txt", "a") {|f| f.puts(person.print_person)}
    end
  end

  def self.write_sorted_by_lastname_to_file
    File.open("results.txt", "a") {|f| f.puts("\nOutput 3:")}
    self.sort_by_lastname.each do |person|
      File.open("results.txt", "a") {|f| f.puts(person.print_person)}
    end
  end

  def self.main_results_writer
    self.create_people_data_from_files
    self.write_sorted_by_gender_to_file
    self.write_sorted_by_birthdate_to_file
    self.write_sorted_by_lastname_to_file
  end

end

Output.main_results_writer
