
module Concerns::Findable

  def find_by_name(name)
    self.all.find {|element| element.name == name}
  end

  def find_or_create_by_name(name)
    found = self.find_by_name(name)
    if found.nil?
      found = self.create(name)
    end
    found
  end

  def sort
    self.all.sort_by {|object| object.name}
  end
end