class Genre 
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :songs 
  
  @@all = []
  
  def initialize(name)
    @name = name
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
  
  def artists
    songs.collect {|song| song.artist}.uniq
  end
  
end 