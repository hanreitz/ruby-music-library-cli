require 'pry'
class MusicLibraryController
    def initialize(path = "./db/mp3s")
        @path = path
        to_import = MusicImporter.new(path)
        to_import.import
    end

    def call
        input = ""
        while input != 'exit'
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            input = gets
            if input == "list songs"
                list_songs
            elsif input == "list artists"
                list_artists
            elsif input == "list genres"
                list_genres
            elsif input == "list artist"
                list_songs_by_artist
            elsif input == "list genre"
                list_songs_by_genre
            elsif input == "play song"
                play_song
            end
        end
    end

    def list_songs
        sorted_songs = Song.all.sort_by(&:name)
        i = 0
        while i < sorted_songs.length
            puts "#{i+1}. #{sorted_songs[i].artist.name} - #{sorted_songs[i].name} - #{sorted_songs[i].genre.name}"
            i += 1
        end
    end

    def list_artists
        sorted_artists = Artist.all.sort_by(&:name)
        sorted_artists.each_with_index{|value, i| puts "#{i+1}. #{value.name}"}
    end

    def list_genres
        sorted_genres = Genre.all.sort_by(&:name)
        sorted_genres.each_with_index{|value, i| puts "#{i+1}. #{value.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist = gets
        songs_by_artist = Song.all.select{|song| song.artist.name == artist}.sort_by(&:name)
        songs_by_artist.each_with_index{|value, i| puts "#{i+1}. #{value.name} - #{value.genre.name}"}
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre = gets
        songs_by_genre = Song.all.select{|song| song.genre.name == genre}.sort_by(&:name)
        songs_by_genre.each_with_index{|value, i| puts "#{i+1}. #{value.artist.name} - #{value.name}"}
    end

    def play_song
        puts "Which song number would you like to play?"
        song = gets.strip.to_i
        sorted_songs = Song.all.sort_by(&:name)
        if song >= 1 && song < sorted_songs.length
            puts "Playing #{sorted_songs[song-1].name} by #{sorted_songs[song-1].artist.name}"
        end
    end
end