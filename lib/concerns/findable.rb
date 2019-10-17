module Concerns::Findable
  
  def create(name)
    noon = self.new(name)
    noon.save
    noon
  end
  
  def find_by_name(name)
    all.detect{ |instance| instance.name == name }
  end
  
  def find_or_create_by_name(name)
    if find_by_name(name)
      find_by_name(name)
    else
      create(name)
    end
  end
  
end