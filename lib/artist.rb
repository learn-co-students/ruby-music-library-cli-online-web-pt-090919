class Artist 
  
  extend Concerns::Findable
  
  attr_accessor :name
  
  @@all = []

 def initialize(name)
    @name = name
    @songs = []
  end
  
  def self.create(artist_inst) 
    new_inst = Artist.new(artist_inst)
    new_inst.save
    new_inst
  end
  
  def save 
    Artist.all << self
  end
  
  def self.all 
    @@all
  end
  
  def self.destroy_all 
    Artist.all.clear
  end
  
  def songs 
    @songs
  end
  
  def add_song(song)
    song.artist = self if song.artist == nil
    songs << song if !(songs.include?(song))
  end
  
  def genres 
    genre_collection = self.songs.collect{|song| song.genre}.uniq
    genre_collection
  end
  
end