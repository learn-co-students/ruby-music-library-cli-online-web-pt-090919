class MusicLibraryController
  
  attr_accessor :path
  
  def initialize(path = './db/mp3s') 
    @path = path
    inst = MusicImporter.new(@path)
    inst.import
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
    sorted_list
  end
  
  def list_artists
    Artist.all.collect{|artist| artist.name}.sort.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist}"
    end
  end
  
  def list_genres
    Genre.all.collect{|genre| genre.name}.sort.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre}"
    end
  end
  
  def list_songs_by_artist
    
    puts "Please enter the name of an artist:"
    input = gets.strip
    if artist = Artist.find_by_name(input)
      artist.songs.sort {|a, b| a.name <=> b.name}.each.with_index(1) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
    
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    chosen_genre = gets
    
    genre_songs = []
    
    Genre.all.each{|genre| genre.songs.each{|song| genre_songs << (song.artist.name + ' - ' + song.name)} if genre.name == chosen_genre}
    
    genre_songs.sort_by do |song|
      song.split(' - ')[1][0]
    end.each_with_index do |song, index|
      puts "#{index + 1}. #{song}"
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    song_number = gets.strip.to_i
    if (1..Song.all.length).include?(song_number)
      song = Song.all.sort_by(&:name).uniq[song_number-1]
      puts "Playing #{song.name} by #{song.artist.name}" if song
    end
  end 


end 
