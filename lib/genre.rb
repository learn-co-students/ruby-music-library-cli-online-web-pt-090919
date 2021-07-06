require_relative "../lib/concerns/findable.rb"
class Genre
  
  extend Concerns::Findable
  
  @@all = []
  attr_accessor :name
  
  def initialize(name)
    @name = name
    @songs = []
    self.save
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def save
    @@all.push(self) unless @@all.include?(self)
  end
  
  def self.create(name)
    x = self.new(name)
    x.save
    x
  end
  
  def songs
    @songs
  end
  
  def artists
    Song.all.select do |song|
      song if song.genre == self
    end.collect do |song|
      song.artist
    end.uniq
  end
  
  
  
end