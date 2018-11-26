require 'pry'

class MusicLibraryController
  attr_accessor :path

  def initialize(path="./db/mp3s")
    @path = path
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = ""

    while input != 'exit'
      input = gets.chomp

      case input
      when 'list songs'
        self.list_songs
      when 'list artists'
        self.list_artists
      when 'list genres'
        self.list_genres
      when 'list artist'
        self.list_songs_by_artist
      when 'list genre'
        self.list_songs_by_genre
      when 'play song'
        self.play_song
      end
    end
  end

  def list_songs
    Song.sort.each_with_index { |song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
  end

  def store_songs
    Song.sort.each_with_index.map { |song| "#{song.artist.name} - #{song.name} - #{song.genre.name}" }
  end

  def list_artists
    Artist.sort.each_with_index { |artist, index| puts "#{index+1}. #{artist.name}" }
  end

  def list_genres
    Genre.sort.each_with_index { |genre, index| puts "#{index+1}. #{genre.name}" }
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp

    artist = Artist.find_by_name(input)
    artist.songs.uniq.sort_by { |song| song.name }.each_with_index { |song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}" } if artist
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp

    genre = Genre.find_by_name(input)
    genre.songs.uniq.sort_by { |song| song.name }.each_with_index { |song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}" } if genre
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp
    if (1..Song.sort.count).to_a.include?(input.to_i)
      song = Song.sort[input.to_i - 1]
      puts "Playing #{song.name} by #{song.artist.name}" if song
    end
  end

end