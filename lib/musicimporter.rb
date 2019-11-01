class MusicImporter
  
  attr_accessor :path
  
  def initialize(path)
    @path = path  
  end
  
  def files
    files = Dir.glob("#{@path}/*.mp3")
    files.collect {|name| name.split("/")[-1]}
  end
  
  def import
    list = self.files
      list.collect do |file|
        file = Song.create_from_filename(file)
      end
  end
  
end