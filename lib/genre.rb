class Genre 
  extend Concerns::Findable
  
  attr_accessor :name 
  attr_reader :genre
  
  @@all = []
  
  def initialize(name, genre=nil)
    @name = name 
    @genre = genre
    @songs = []
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.destroy_all 
    self.all.clear
  end 
  
  def save 
    @@all << self 
  end 
  
  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end 
  
  def songs
    @songs
  end 
  
  def artists
    artist_collection = self.songs.collect {|song| song.artist}.uniq 
    artist_collection
  end 
  
end 