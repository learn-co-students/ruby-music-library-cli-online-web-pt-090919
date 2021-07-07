class Artist 
  extend Concerns::Findable
  
  attr_accessor :name, :songs 
  
  @@all = []
  
  
  def initialize(name)
    @name = name 
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
    artist = self.new(name)
    artist.save
    artist
  end 
  
  def add_song(song)
    song.artist= self if song.artist==nil
    songs << song if !(songs.include?(song))
  end 
  
  def genres
    genre_collection = self.songs.collect {|song| song.genre}.uniq
    genre_collection
  end 
  
end 
