class Song 
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
  end
  
  def self.create(song_inst)
    new_inst = Song.new(song_inst)
    new_inst.save
    new_inst
  end
  
  def save
    Song.all << self
  end
  
  def self.all 
    @@all
  end
  
  def self.destroy_all 
    Song.all.clear
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    @genre.songs << self if !(@genre.songs.include?(self))
    # binding.pry
  end
  
  def self.find_by_name(song_name)
    self.all.find{|song| song if song.name == song_name}
  end
  
  def self.find_or_create_by_name(song_name)
    found_the_instance = self.find_by_name(song_name)
    nope_creating_one = self.create(song_name) if !(found_the_instance)
    
    found_the_instance ? found_the_instance : nope_creating_one
  end
  
  def self.new_from_filename(file_name)
    file_inst = file_name.gsub(/(\.mp3)/,'')
    file_inst = file_inst.split(" - ")
    artist = Artist.find_or_create_by_name(file_inst[0])
    genre = Genre.find_or_create_by_name(file_inst[2])
    song = Song.find_or_create_by_name(file_inst[1])
    song.genre = genre
    song.artist = artist
    song
  end 
  
  def self.create_from_filename(file_name)
     file = Song.new_from_filename(file_name)
     file.save
     file
  end 

end
