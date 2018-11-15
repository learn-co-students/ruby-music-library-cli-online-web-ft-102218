require 'pry'

class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist != nil
    self.genre=(genre) if genre != nil
    @@all << self
  end

  def save
    @@all << self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if !(genre.songs.include?(self))
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    @@all.find { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    song = Song.find_by_name(name)
    if song.nil?
      song = Song.create(name)
    end
    song
  end

  def self.new_from_filename(filename)
    filearray = filename.split(" - ")
    song = Song.new(filearray[1])
    song.artist = Artist.find_or_create_by_name(filearray[0])
    song.genre = Genre.find_or_create_by_name(filearray[2].gsub(".mp3", ""))
    song.save
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

  def self.all
    @@all.uniq
  end

  def self.destroy_all
    @@all = []
  end
end
