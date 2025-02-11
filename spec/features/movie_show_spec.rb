require 'rails_helper'

feature 'Movie show page' do
  it 'shows movie details', :vcr do
    user = create(:user)
    movie = MovieFacade.new(11)
    visit movie_path(id: user.id, movie_id: movie.id)

    expect(page).to have_content('Star Wars')
    expect(page).to have_content('Vote: 8.2')
    expect(page).to have_content('Runtime: 121 minutes')
    expect(page).to have_content('Genre: Adventure, Action, Science Fiction')
    expect(page).to have_content('Summary: Princess Leia is captured and held hostage')

    within('.cast_members') do
      expect(page).to have_selector('p', count: 10)  
    end

    within(".reviews") do
      expect(page).to have_content("5 Reviews")

      movie.reviews.each do |review|
        expect(page).to have_link(review[:author], href: review[:url])
      end
    end

    expect(page).to have_button('Create a viewing party')
    expect(page).to have_button('Discover Page')
  end
end
