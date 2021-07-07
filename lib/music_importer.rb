require 'pry'

class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    files = Dir[@path + "/*.mp3"]
    normalize = files.map {|f| f.gsub!(@path+"/", "")}
  end
  
  def import
    self.files.each {|name| Song.create_from_filename(name)}
  end

end