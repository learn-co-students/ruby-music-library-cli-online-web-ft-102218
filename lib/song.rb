require "pry"

class Song

@@all = [] 

attr_accessor :name, :artist, :genre
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist= artist if artist!=nil
    self.genre= genre if genre!=nil
  end
   
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end 
  
  def save
    @@all << self
  end
  
  def self.create(name) 
    song = self.new(name)
    song.save
    song 
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre= (genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end
  
  
  def self.find_by_name(name)
    @@all.find {|song| song.name == name}
  end
  
  def self.find_or_create_by_name(name)
      self.find_by_name(name) || self.create(name)
  end
  
  def self.new_from_filename(filename)
    filename_array = filename.split(" - ")
    artist_name = filename_array[0]
    song_name = filename_array[1]
    genre_type = filename_array[2].gsub(".mp3", "")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_type)
    song = new(song_name, artist, genre)
    song
  end
  
  def self.create_from_filename(filename)
      song = self.new_from_filename(filename)
      @@all << song
  end
  
end 