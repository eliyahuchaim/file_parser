class Person

  attr_reader :firstname, :lastname, :gender, :favorite_color, :birthday

  @@all = []

  def initialize(lastname, firstname, gender, birthday, favorite_color)
    @firstname = firstname
    @lastname = lastname
    @gender = gender
    @favorite_color = favorite_color
    @birthday = birthday
    @@all << self
  end

  def self.all
    @@all
  end

  def print_person
    self.lastname + " " + self.firstname + " " + self.gender + " " + self.birthday + " " + self.favorite_color
  end

end
