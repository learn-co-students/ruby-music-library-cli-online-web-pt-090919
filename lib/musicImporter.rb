require 'pry'

class MusicImporter
  
  attr_accessor :path
  
  def initialize(path)
    @path = path
  end
  
  def files
    all_MP3_files = Dir.entries(@path).select{|entry| entry.include?('mp3')}
    all_MP3_files
  end
  
  def import 
    files.each do |file|
      Song.create_from_filename(file)
    end
  end
  
end