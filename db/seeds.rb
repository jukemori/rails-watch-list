# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'json'
require 'fileutils'

puts "Cleaning up database..."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts "Database cleaned"

lists = [
  { name: 'Action', photo: './app/assets/images/lists_genre/daniel-stuben-n9yEuk5HhSM-unsplash.jpg' },
  { name: 'Drama', photo: './app/assets/images/lists_genre/richard-horne-66i2U4Rxras-unsplash.jpg' },
  { name: 'Romance', photo: './app/assets/images/lists_genre/everton-vila-AsahNlC0VhQ-unsplash.jpg' },
  { name: 'Superhero', photo: './app/assets/images/lists_genre/actionvance-n-2_KHgeAy0-unsplash.jpg' },
  { name: 'Comedy', photo: './app/assets/images/lists_genre/tim-mossholder-imlD5dbcLM4-unsplash.jpg' },
  { name: 'Horror', photo: './app/assets/images/lists_genre/sebastiaan-stam-RChZT-JlI9g-unsplash.jpg' },
  { name: 'Family', photo: './app/assets/images/lists_genre/tyler-nix-V3dHmb1MOXM-unsplash.jpg' }
]


lists.each do |list_info|
  list = List.create!(name: list_info[:name])
  puts "Getting photo for #{list_info[:name]}..."
  list.photo.attach(io: File.open(list_info[:photo]), filename: 'list.png', content_type: 'image/png')
end

puts "Lists created"

url = "https://api.themoviedb.org/3/movie/popular?api_key=344f0f780755bea2b31e065cd88c6cc0&language=en-US&adult=false"
30.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(URI.open("#{url}&page=#{i + 1}").read)['results']
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    base_poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['poster_path']}",
      rating: movie['vote_average']
    )
  end
end
# puts "Movies created"
