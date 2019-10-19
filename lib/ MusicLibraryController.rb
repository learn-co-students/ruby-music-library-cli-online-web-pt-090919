class MusicLibraryController
  attr_accessor :path
  
  def initialize(path = './db/mp3s')
    @path = path
    fresh_importer = MusicImporter.new(path)
    Song.all << fresh_importer.import
  end 
  
   def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    user_input = gets.chomp
    case user_input
    when "get songs"
      self.get_songs
    when "get artists"
      self.get_artists
    when "get genres"
      self.get_genres
    when "get artist"
      self.get_songs_by_artist
    when "get genre"
      self.get_songs_by_genre
    when "play song"
      self.play_song
    when "exit"
      'exit'
    else
      call
    end
  end 
  
  def list_songs
    music_library = self.all.sort {|song_a, song_b|song_a <=> song_b = song.name}
    music_library.each do |song|
      puts "#{music_library.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end 
 end
end