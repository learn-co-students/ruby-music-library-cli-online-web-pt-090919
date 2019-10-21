require 'pry'
class Artist
  # Extends the Concerns::Findable module
  extend Concerns::Findable 
  # extend: responsible for defining method as a class method 
  # vs. an instance method (include keyword)
  
  attr_accessor :name, :songs
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  # initializes, saves, and returns the song
  def self.create(name)
    new_artist = self.new(name)
    new_artist.save
    new_artist
  end
  
  # ASSOCIATIONS

  # Assigns current artist to song's 'artist' property (song belongs to artist)
  # Doesn't assign artist if song already has an artist
  def add_song(new_song)
    new_song.artist = self unless new_song.artist
    
    # add song to cirrent artist's 'songs' collection
    # doesn't add the song to current artist's 'songs' collection if 
    # it already exists therein
    self.songs << new_song
    self.songs = self.songs.uniq
  end
  
  # returns collection of genres for all of the artist's songs
  def genres
    # collects genres through its songs instead of maintaining its own 
    # @genres instance variable (artist has many genres through songs)
    
    return self.songs.map(&:genre).uniq
    # return self.songs.map { |song| song.genre }.uniq
  end
  
  

  
end
