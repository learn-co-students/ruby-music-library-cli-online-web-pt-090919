require 'bundler'
Bundler.require

module Concerns
  module Findable
    
    
    #class methods
    def find_by_name(song_name)
      all.find {|song| song if song.name==song_name}
    end 
    
    def find_or_create_by_name(song_name)
      found_the_instance=find_by_name(song_name)
      nope_so_then_create_one=create(song_name) if !(found_the_instance)
      
      found_the_instance ? found_the_instance : nope_so_then_create_one
    end       
    
  end 
end

require_all 'lib'
