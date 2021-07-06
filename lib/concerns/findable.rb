module Concerns::Findable
  def find_by_name(song_name)
     self.all.find{|song| song if song.name == song_name}
  end 
  
  def find_or_create_by_name(song_name)
    found_the_instance = self.find_by_name(song_name)
    nope_creating_one = self.create(song_name) if !(found_the_instance)
    
    found_the_instance ? found_the_instance : nope_creating_one
  end 
end