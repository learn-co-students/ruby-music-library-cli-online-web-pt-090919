module Concerns::Findable

  def find_by_name(name)
    all.detect {|s| s.name == name}
    # self
  end

  def find_or_create_by_name(name)
    # binding.pry

    if !all.detect {|s| s.name == name}
      self.create(name)
    else
      self.find_by_name(name)
    end
  end
end
