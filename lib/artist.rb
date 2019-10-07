require 'pry'
require_relative "../lib/concerns/findable.rb"

class Artist
  extend Concerns::Findable

attr_accessor :name, :songs
attr_reader :genres
@@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
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
    if !song.artist
      song.artist = self
    end
    if !songs.include?(song)
      @songs << song
    end
  end

  def genres
    genres = []
    self.songs.select do |song|
      song.artist == self
      genres << song.genre
    end
    genres.uniq
  end
end
