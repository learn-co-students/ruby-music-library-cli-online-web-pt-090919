require_relative './concerns/findable.rb'

class Song

  extend Concerns::Findable
  attr_reader :artist, :genre
  attr_accessor :name
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  @@all = []
  
  def self.all
    @@all
  end
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
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

  def self.new_from_filename(filename)
    info = filename.split(" - ")
    info[2] = info[2].split(".")
    
    sonfile = Song.find_or_create_by_name(info[1])
    artfile = Artist.find_or_create_by_name(info[0])
    genfile = Genre.find_or_create_by_name(info[2][0])
    
    sonfile.artist = artfile
    sonfile.genre = genfile
    
    sonfile
  end
  
  def self.create_from_filename(filename)
    new_from_filename(filename)
  end

end

