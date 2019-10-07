require 'pry'
require_relative "../lib/concerns/findable.rb"


class Genre
  extend Concerns::Findable

attr_accessor :name, :songs
attr_reader :artists

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
    genre = self.new(name)
    genre.save
    genre
  end

  def artists
    artists = []
    self.songs.select do |song|
      song.genre == self
      artists << song.artist
    end
    artists.uniq
  end
end
