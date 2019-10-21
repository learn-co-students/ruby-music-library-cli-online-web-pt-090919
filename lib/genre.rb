class Genre
  #extends the Concerns::Findable module
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  
  @@all = []
  
  def initialize(name)
    @name = name
    # genre has many songs
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
  
  #initializes, saves, and returns the song
  def self.create(name)
    new_genre = self.new(name)
    new_genre.save
    new_genre
  end
  
  # ASSOCIATIONS
  
  # returns a collection of artists for all of the genre's songs 
  # (genre has many artists through songs)
  def artists
    return self.songs.map(&:artist).uniq
    # return self.songs.map { |song| song.artist }.uniq
  end
end
