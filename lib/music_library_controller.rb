require "pry"
class MusicLibraryController
  
  def initialize(path="./db/mp3s")
    MusicImporter.new(path).import
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
    
    x = gets.chomp
    
    if x == "list songs"
      self.list_songs
    elsif x == "list artists"
      self.list_artists
    elsif x == "list genres"
      self.list_genres
    elsif x == "list artist"
      self.list_songs_by_artist
    elsif x == "list genre"
      self.list_songs_by_genre
    elsif x == "play song"
      self.play_song
    end
    
    unless x == "exit"
      call
    end
  end
  
  def list_songs
    x = Song.all.sort do |a, b|
      a.name <=> b.name
    end
    
    x.each_with_index do |song, num|
      puts "#{num + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
    x
  end
  
  def list_artists
    x = Artist.all.sort do |a, b|
      a.name <=> b.name
    end
    
    x.each_with_index do |artist, num|
      puts "#{num + 1}. #{artist.name}"
    end
  end
  
  def list_genres
    x = Genre.all.sort do |a, b|
      a.name <=> b.name
    end
    
    x.each_with_index do |genre, num|
      puts "#{num + 1}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    
    name = gets.chomp
    
    x = Song.all.select do |song|
      song.artist.name == name
    end
    
    x = x.sort do |a, b|
      a.name <=> b.name
    end
    
    x.each_with_index do |song, num|
      puts "#{num + 1}. #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    
    genre = gets.chomp
    
    x = Song.all.select do |song|
      song.genre.name == genre
    end
    
    x = x.sort do |a, b|
      a.name <=> b.name
    end
    
    x.each_with_index do |song, num|
      puts "#{num + 1}. #{song.artist.name} - #{song.name}"
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    i = gets.chomp.to_i - 1
    
    if i < Song.all.count && i >= 0
    
      x = Song.all.sort do |a, b|
        a.name <=> b.name
      end
    
      puts "Playing #{x[i].name} by #{x[i].artist.name}"
    end
  end
  
  
  
  
end