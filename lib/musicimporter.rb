class MusicImporter
  
  attr_accessor :path
  
  def initialize(path)
    @path = path
  end 
  
  def files 
    files = Dir.glob("#{path}**/*")
    files = files.collect{|file|file.scan(/(?<=mp3s\/)(.*)/)}.flatten
  end 
  
  def import 
    fresh_file = self.files 
    fresh_file.collect {|file| file = Song.create_from_filename(file)}
  end 
end 