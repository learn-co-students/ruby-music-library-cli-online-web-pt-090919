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
    when "list songs"
      self.list_songs
    when "list artists"
      self.list_artists
    when "list genres"
      self.list_genres
    when "list artist"
      self.list_songs_by_artist
    when "list genre"
      self.list_songs_by_genre
    when "play song"
      self.play_song
    when "exit"
      'exit'
    else
      call
    end
  end 
  
  def library(content = Song)
    sorted_list = content.all.collect{|object|object if object.class == content }
    sorted_list = sorted_list.delete_if {|object|object==nil}
    sorted_list.uniq
  end

  def list_songs
    sorted_list = self.library.sort_by {|song|song.name}
    sorted_list.each do |song|
      puts "#{sorted_list.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    sorted_list = self.library.sort_by {|artist|artist.name}
    sorted_list.collect.each do |artist|
      puts "#{sorted_list.index(artist) + 1}. #{artist.name}"
    end
  end
end