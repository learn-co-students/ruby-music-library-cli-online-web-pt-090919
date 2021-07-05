class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs, :genres
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
    new = Artist.new(name)
    new.save
    new
  end
  
  def add_song(song)
    if @songs.include? song
    else
      @songs << song
    end
    
    if song.artist == nil
      song.artist = self
    end
  end
  
  def genres
    @genres = []
    self.songs.each do |song|
      if !@genres.include?(song.genre)
        @genres << song.genre
      end
    end
    @genres
  end
  
end