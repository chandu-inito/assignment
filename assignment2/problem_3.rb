require 'nokogiri'
require 'open-uri'

class Movie
  def initialize(n)
    @num_of_movies = n
  end

  def get_movie_data

    movie_details = []
    doc = Nokogiri::HTML(URI.open('https://www.imdb.com/chart/top'))
  
    1.upto(@num_of_movies) do |i|
      rank = doc.css("tbody td[class='titleColumn']")[i-1].text.split("\n")[1].strip.to_i
      movie_name = doc.css("tbody td[class='titleColumn']")[i-1].text.split("\n")[2].strip
      movie_link = "https://www.imdb.com" + doc.css("tbody td[class='titleColumn'] a")[i-1]['href']
      movie_details << get_movie_cast(movie_link).prepend(movie_name)
    end
    movie_details
  end

  def get_movie_cast(movie_link)

    movie_cast = []
  
    individual_movie_html = Nokogiri::HTML(URI.open(movie_link))
    individual_movie_html.css("div[data-testid='title-cast-item'] a[data-testid='title-cast-item__actor']").each do |actor|
      movie_cast << actor.text
    end
    movie_cast
  end
end

class Query
  def initialize(movie_details, query_actor, m)
    @movie_details = movie_details
    @query_actor = query_actor
    @max_movies = m
  end

  def process_query
    movies_list = []
    @movie_details.each do |movie|
      movies_list << movie[0] if movie.slice(1..).include?(@query_actor)
      break if movies_list.length==@max_movies
    end
    movies_list
  end
end

n = ARGV[0].to_i
query_actor = ARGV[1]
m = ARGV[2].to_i

movies = Movie.new(n)
movie_details = movies.get_movie_data

query = Query.new(movie_details, query_actor, n)
p query.process_query
