module Concerns::Findable
  def find_by_name(name)  
    all.find {|a|a.name == name}
  end
 
 # Finds (not recreate) an existing instance with the provided name
 # if one exists in @@all isn't hard-coded
 # Invokes .find_by_name instead of re-coding the same functionality
 # Invokes the extended class's .create method, passing in the provided name, if an existing match is not found
 
  def find_or_create_by_name(name)
    find_by_name(name) || self.create(name)
  end
end