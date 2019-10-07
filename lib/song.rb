require 'pry'

class Song
attr_accessor :name
attr_reader :artist, :genre
@@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    self.class.all << self
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def self.create(name)
    song = self.new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    all.detect {|s| s.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(filename)
    song_name = filename.split(" - ").to_a[1]
    artist_name = filename.split(" - ").to_a[0]
    song_genre = filename.split(" - ").to_a[2].gsub(".mp3", "")
    self.find_or_create_by_name(song_name)
    binding.pry
    song.artist = artist_name
    # artist=(artist_name)
    # genre=(song_genre)
    # name=(song_name)

  end
end

    # find_or_create_by_name(name)
    # song.artist=(artist)
    # song.genre=(genre)
    #
    # song




# binding.pry
    # song = self.new(song_name)
    # song.artist=(artist)
    # song
