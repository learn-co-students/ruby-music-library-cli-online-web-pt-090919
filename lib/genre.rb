class Genre 
  
  extend Concerns::Findable
  
  attr_accessor :name 

  @@all = []
    
      def initialize(name)
    @name = name
    @songs = []
     end
  
    def self.all 
    @@all
    end
  
  def self.create(genre_inst)
    new_inst = Genre.new(genre_inst)
    new_inst.save 
    new_inst
  end
  
  def save 
    Genre.all << self
  end
  
  def self.destroy_all 
    Genre.all.clear
  end
  
  def songs 
    @songs
  end
  
  def artists 
    self.songs.collect{|song| song.artist}.uniq
  end
  
end
