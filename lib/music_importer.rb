require "pry"
class MusicImporter
  
  def initialize(path)
    @path = path
  end
  
  def path
    @path
  end
  
  def files
    dir = Dir.open(@path).children
  end
  
  def import
    self.files.each do |filename|
      Song.create_from_filename(filename)
    end
  end
  
end