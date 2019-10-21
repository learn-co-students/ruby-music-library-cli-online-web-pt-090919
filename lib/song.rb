require 'pry'
class Song
  # include Concerns::Findable
  
  attr_accessor :name, :artist, :genre
  
  @@all = []
  
  # can be invoked with an optional argument- Artist object to be assigned
    # to the song's 'artist' property (song belongs to artist)
  def initialize(name, artist = nil, genre = nil)
    @name = name
    #invokes #artist= (not setting @artist instance variable) to ensure that associations are created upon initialization
    self.artist=(artist) if artist != nil
    self.genre=(genre) if genre != nil
  end
  
  # Invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)
  def artist=(artist)
    @artist = artist
    #Invokes Artist#add_song to add itself to the artist's songs collection 
      # (artist has-many songs) 
    self.artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    @genre.songs << self unless @genre.songs.include?(self)
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
    new_song = self.new(name)
    new_song.save
    new_song
  end
  
  # Finds a song instance in @@all by the name property of the song
  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end
  
   # Returns (not recreate) an existing song w/  provided name if one exists in @@all
   # Creates a song if an existing match is not found
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end
  
  # for MusicImporter
  # initializes a song based on the passed-in filename
  def self.new_from_filename(filename)
    # Parse filename to find sone name and artist name 
    # Eg. filename = "Thundercat - For Love I Come - dance.mp3"
    
    parsed = filename.split(" - ")
    artist_name = parsed[0]
    song_name = parsed[1]
    genre_name = (parsed[2]).chomp(".mp3") #remove .mp3 
    
    # Invokes the appropriate Findable methods so as to avoid duplicating objec
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    # Create new song instance using string from file that's passed
    # initializes a song based on the passed-in filename
    new_instance = self.new(song_name, artist, genre)
    
    # Return new song instance
    new_instance
  end
  
  # Initializes and saves a song based on the passed-in filename
  # invokes .new_from_filename instead of re-coding the same functionality
  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end

end