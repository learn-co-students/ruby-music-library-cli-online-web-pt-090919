class MusicLibraryController
  
  def initialize(filepath = "./db/mp3s") #'path' arg to './db/mp3s'
    # creates new MusicImporter object, passing in 'path' value
    importer = MusicImporter.new(filepath)
    # #invokes #import method on the created MusicImporter object
    importer.import
  end
  
  # welcome the user
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
     
    # Gets user input
    # Loops and asks for user input until they type in exit
    # .chomp remove linebreak from user input string
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
    else #if nothing matches
      call
    end 
  end

  # CLI METHODS
  # prints all songs in the music lib in numbered list (alphabetized by song name)
  def list_songs
    self.sorted_list_songs.each_with_index do |song, idx|
      puts "#{(idx + 1).to_s}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def sorted_list_songs
    sorted_list = Song.all.sort_by { |song| song.name }
    return sorted_list
  end
  
  # prints all artists in music lib in a numbered list (alphabetized by artist name)" 
  def list_artists
    sorted_list = Artist.all.sort_by {|artist| artist.name}
    sorted_list.each_with_index do |artist, idx|
      puts "#{(idx + 1).to_s}. #{artist.name}"
    end
  end
  
  # prints all genres in music lib in a numbered list (alphabetized by genre name) 
   def list_genres
    sorted_list = Genre.all.sort_by {|artist| artist.name}
    sorted_list.each_with_index do |genre, idx|
      puts "#{(idx + 1).to_s}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    # Prompts the user to enter an artist 
    puts "Please enter the name of an artist:"
    
    # Accepts user input
    input = gets.chomp
    
    # Prints all songs by a particular artist in numbered list (alphabetized by song name)
    # does nothing if no matching artist is found (nil)
    if artist = Artist.find_by_name(input) 
      sorted_list = artist.songs.sort_by {|song| song.name}
      sorted_list.each_with_index do |song, idx|
         # E.g. "1. Green Aisles - country"
         puts "#{(idx+1).to_s}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre
    # Prompts the user to enter a genre
    puts "Please enter the name of a genre:"
    
    # Accepts user input
    input = gets.chomp
    
    # prints all songs by a particular genre in a numbered list (alphabetized by song name)
    # does nothing if no matching genre is found (nil)
    if genre = Genre.find_by_name(input)
      sorted_list = genre.songs.sort_by {|song| song.name}
        sorted_list.each_with_index do |song, idx|
           # "1. Real Estate - It's Real"
           puts "#{(idx+1).to_s}. #{song.artist.name} - #{song.name}"
        end
    end
  end
  
  def play_song
    # prompts user to choose a song from the alphabetized list output by #list_songs
    puts "Which song number would you like to play?"
    song_num = gets.strip.to_i
    
    # 'plays' the matching song from the alphabetized list output by #list_songs
    # e.g. "Playing Larry Csonka by Action Bronson")
    # doesn't 'puts' anything out if a matching song is not found
    # checks that user entered a num between 1 - total num of songs in the lib
    if (1..Song.all.length).include?(song_num)
      chosen_song = self.sorted_list_songs[song_num - 1] #song number input converted to index
      puts "Playing #{chosen_song.name} by #{chosen_song.artist.name}"
    end
  end
  
end