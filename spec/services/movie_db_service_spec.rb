require 'rails_helper'

RSpec.describe MovieDbService do
  before(:all) do
    @service = MovieDbService.new
  end

  it 'searches for movies', :vcr do
      data = @service.search_movies('Star Wars')

      expect(data).to be_a(Hash)
      expect(data[:results]).to be_an(Array)
      expect(data[:results].first[:title]).to be_a(String)
  end

  it 'retrieves movie details', :vcr do
      data = @service.movie_details(11)

      expect(data).to be_a(Hash)
      expect(data[:title]).to eq('Star Wars')
  end
end
