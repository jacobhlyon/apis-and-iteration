require 'rest-client'
require 'json'
require 'pry'

def translate(url)
  #request from the API and then change to a hash using JSON
  JSON.parse(RestClient.get(url))
end

# def make_character_array
#   count = 1
#   character_array = []
#   while count < 88
#     character_url = "http://www.swapi.co/api/people/" + count.to_s + "/"
#     character_array << translate(character_url)
#     #binding.pry
#     count += 1
#   end
#   #character_array
#   binding.pry
# end

# def find_character_page(character)
#   count = 1
#   character_array = []
#   until character == translate("http://www.swapi.co/api/people/" + count.to_s + "/")
#    # character_url = "http://www.swapi.co/api/people/" + count.to_s + "/"
#     character_array << translate(character_url)
#     count += 1
#   end
# end


def get_character_movies_from_api(character, api = 'http://www.swapi.co/api/people/')
  #make the web request
  #all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = translate(api)
  #binding.pry

  
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  film_array = []
  character_hash["results"].each do |intial_bio|
    if intial_bio["name"] == character
      film_array = intial_bio["films"]
    end
  end
  if film_array == []
    get_character_movies_from_api(character, character_hash["next"])
  else
    film_array.map do |url|
      translate(url)
    end
  end
end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

# parse_character_movies(get_character_movies_from_api("C-3PO"))

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?





