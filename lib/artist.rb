require_relative './concerns/findable.rb'

class Artist

  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []
  
  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @songs = []
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  # def self.create(name)
  #   noon = self.new(name)
  #   noon.save
  #   noon
  # end
  
  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless @songs.include?(song)
  end
  
  def genres
    @songs.map { |song| song.genre }.uniq
  end

end

