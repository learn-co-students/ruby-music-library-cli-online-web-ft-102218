module Concerns::Findable

  def find_by_name(name)
    self.all.find { |a| a.name == name }
  end

  def find_or_create_by_name(name)
    a = self.find_by_name(name)
    if a.nil?
      a = self.create(name)
    end
    a
  end

  def sort
    self.all.sort_by { |obj| obj.name }
  end
end
