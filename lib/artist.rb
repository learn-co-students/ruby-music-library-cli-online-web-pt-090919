require_relative "../lib/concerns/findable.rb"
class Artist
  
  extend Concerns::Findable
  
  @@all = []
  attr_accessor :name
  
  def initialize(name)
    @name = name
    @songs = []
    self.save
  end
  
  def songs
    @songs
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
  
  def add_song(song)
    unless @songs.include?(song) || song.artist
      song.artist = self
      @songs.push(song)
    end
  end
  
  def genres
    Song.all.select do |song|
      song if song.artist == self
    end.collect do |song|
      song.genre
    end.uniq
  end
  
  
  
end