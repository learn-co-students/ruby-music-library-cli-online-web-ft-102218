require_relative './concerns/module_findable'

class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    @@all << self
  end

  def add_song(song)
    song.artist = self if song.artist.nil?
    @songs << song if !(@songs.include? song)
  end

  def genres
    @songs.map { |song| song.genre }.uniq
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def self.all
    @@all.uniq
  end

  def self.destroy_all
    @@all = []
  end
end
