class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs, :artists
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
    new = Genre.new(name)
    new.save
    new
  end
  
  def artists
    @artists = []
    self.songs.each do |song|
      if !@artists.include?(song.artist)
        @artists << song.artist
      end
    end
    @artists
  end
  
  def add_song(song)
    if @songs.include? song
    else
      @songs << song
    end
    
    if song.genre == nil
      song.genre = self
    end
  end
  
end