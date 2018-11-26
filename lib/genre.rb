require_relative './concerns/module_findable'

class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def artists
    @songs.map {|s| s.artist}.uniq
  end

  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end

  def self.all
    @@all.uniq
  end

  def self.destroy_all
    @@all.clear
  end
end
