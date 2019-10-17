require 'pry'

class MusicLibraryController
  
  attr_accessor :files
  
  def initialize(path = "./db/mp3s")
    @files = MusicImporter.new(path).import
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

    input = gets until input == "exit"
  end

  def song_organizer
    list = files.map{ |file| file.split(" - ") }
    list.sort!{ |a,b| a[1] <=> b[1] }
    list.each{ |file| 4.times{file[2].chop!} }
    alpha = list.map{ |file| file.join(" - ") }
    alpha.map.each_with_index{ |file, index| "#{index+1}. #{file}" }
  end
  
  def list_songs
    song_organizer.each{ |line| puts line }
  end

  def list_artists
    Artist.all.sort{ |a,b|
      a.name <=> b.name
    }.each_with_index{ |art, index|
      puts "#{index+1}. #{art.name}"
    }
  end

  def list_genres
    Genre.all.sort{ |a,b|
      a.name <=> b.name
    }.each_with_index{ |gen, index|
      puts "#{index+1}. #{gen.name}"
    }
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets
    artobject = Artist.all.detect{|art|art.name == artist}
    return unless artobject
    
    artgroup = artobject.songs.sort{ |a,b| a.name <=> b.name }
    artgroup.each_with_index{ |song, index|
      puts "#{index+1}. #{song.name} - #{song.genre.name}"
    }
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets
    genobject = Genre.all.detect{|gen|gen.name == genre}
    return unless genobject
    gengroup = genobject.songs.sort{ |a,b| a.name <=> b.name }
    gengroup.each_with_index{ |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name}"
    }
  end

  def play_song
    puts "Which song number would you like to play?"
    sel_num = gets.to_i
    return unless sel_num <= song_organizer.length && sel_num > 0
    sel_song = song_organizer[sel_num-1][3..-1].split(" - ")
    puts "Playing #{sel_song[1]} by #{sel_song[0]}"
  end

end