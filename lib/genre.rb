require_relative './concerns/module_findable'

class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    @@all << self
  end

  def save
    @@all << self
  end

  def artists
    @songs.map { |song| song.artist }.uniq
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def self.all
    @@all.uniq
  end

  def self.destroy_all
    @@all = []
  end
end
