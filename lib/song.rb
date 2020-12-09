require 'pry'
class Song
    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        artist != nil ? self.artist = artist : nil
        genre != nil ? self.genre = genre : nil
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
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

    def genre=(genre)
        @genre = genre
        if genre.songs.include?(self) == false
            genre.songs << self
        end
    end

    def self.find_by_name(name)
        self.all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
    end

    def self.new_from_filename(filename)
        filename_array = filename.split(" - ")
        artist_input = filename_array[0]
        name_input = filename_array[1]
        genre_input = filename_array[2].gsub(".mp3","")
        artist = Artist.find_or_create_by_name(artist_input)
        genre = Genre.find_or_create_by_name(genre_input)
        new_song = self.new(name_input, artist, genre)
        new_song
    end

    def self.create_from_filename(filename)
        new_song = self.new_from_filename(filename)
        new_song.save
        new_song
    end

end