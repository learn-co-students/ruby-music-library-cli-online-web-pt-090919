require_relative './concerns/findable.rb'

class Artist
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def genres
    songs.map{|song| song.genre}.uniq
  end
  
  def save
    @@all << self
  end
  
  def add_song(song)
    song.artist = self if song.artist == nil
    @songs << song if !@songs.include?(song)
  end
  
  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
end