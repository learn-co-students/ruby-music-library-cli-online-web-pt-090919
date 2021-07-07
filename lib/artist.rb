class Artist
  extend Concerns::Findable
  
  attr_accessor :songs
  attr_reader :name 
  
  @@all = []
  
  def initialize(name)
    @name = name
    @@all << self
    @songs = []
  end
  
  def self.all 
    @@all
  end
  
  def name=(name)
    @name = name
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    self.class.all << self
  end
  
  def self.create(name)
    x = self.new(name)
    x.save
    x
  end
  
  def add_song(song)
      song.artist = self unless song.artist
      @songs << song unless songs.include?(song)
  end
  
  def genres
    x = songs.collect do |song|
      song.genre
    end.uniq
  end
  
end 