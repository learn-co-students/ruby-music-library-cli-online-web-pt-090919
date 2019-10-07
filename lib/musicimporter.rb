class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(path).keep_if {|f| f.include?(".mp3")}
  end

  # def import
  #   files.each {|f| Song.create_from_filename(f)}
  # end
end
