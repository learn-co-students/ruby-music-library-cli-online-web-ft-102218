require_relative './concerns/module_findable'

class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    song.artist = self if song.artist.nil?
    @songs << song if !(@songs.include? song)
  end

  def genres
    @songs.map {|s| s.genre}.uniq
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  def self.all
    @@all.uniq
  end

  def self.destroy_all
    @@all.clear
  end
end