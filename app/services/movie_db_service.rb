class MovieDbService
  def top_movies
    response = get_url("/3/movie/top_rated")
    response[:results]
  end  

  def search_movies(query)
    get_url("/3/search/movie", { query: query } )
  end

  def movie_details(id)
    get_url("/3/movie/#{id}")
  end

  def movie_credits(id)
    get_url("/3/movie/#{id}/credits")
  end  

  def movie_reviews(id)
    response = get_url("/3/movie/#{id}/reviews")
    response[:results]
  end

  private

  def get_url(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def conn
    Faraday.new(url: 'https://api.themoviedb.org') do |req|
      req.headers['Authorization'] = "Bearer #{ENV['TMDB_V4_TOKEN']}"
    end
  end
end
