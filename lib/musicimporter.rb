# a MusicImporter class that works with your Song, Genre, and Artist objects
# to import a directory of MP3 files

class MusicImporter
  attr_reader :path
  
  @@files_array = []
  
  # Accepts a file path to parse MP3 files from
  def initialize(filepath)
    @path = filepath
    @@files_array << self
    self.files
  end
  
  def self.files_array
    @@files_array
  end
  
  # Loads all the MP3 files in the path directory (array)
  # normalizes the filename to just the MP3 filename with no path
  def files
    @@files_array = Dir.entries(self.path).select {|f| !File.directory? f}
  end
  
  # Imports files into the library by invoking Song.create_from_filename
  def import
    @@files_array.collect { |filename| Song.create_from_filename(filename) }  
  end
  
end
