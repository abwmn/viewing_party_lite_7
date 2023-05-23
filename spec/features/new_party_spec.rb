require 'rails_helper'

RSpec.describe 'New Movie Party Page' do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @movie = MovieFacade.new(11)
  end

  it 'shows movie details and form to create a new viewing party', :vcr do
    visit new_movie_party_path(@user1.id, @movie.id)

    expect(page).to have_content(@movie.title)
    expect(find_field('Duration of Party (in minutes)').value).to eq @movie.runtime.to_s
    expect(page).to have_content('When:')
    expect(page).to have_content('Invite:')
    expect(page).to have_button('Create Party')

    within '#invitees' do
      expect(page).to have_content(@user2.name)
      expect(page).to have_content(@user3.name)
    end
  end

  it 'creates a new viewing party when form is filled out correctly', :vcr do
    visit new_movie_party_path(@user1, @movie.id)
    
    fill_in 'Duration of Party (in minutes)', with: '150'
    select '2023', from: 'party_datetime_1i'
    select 'December', from: 'party_datetime_2i'
    select '25', from: 'party_datetime_3i'
    check @user2.name

    click_button 'Create Party'

    expect(current_path).to eq(user_path(@user1))
    within '#parties' do
      within '.party' do
        expect(page).to have_content('Hosting')
        expect(page).to have_content(@movie.title)
      end
    end
  end

  it 'does not create a new viewing party when duration is less than movie length', :vcr do
    visit new_movie_party_path(@user1, @movie.id)

    fill_in 'Duration of Party (in minutes)', with: "#{@movie.runtime - 1}" 
    click_button 'Create Party'
    expect(page).to have_content('Error')
    expect(page).to have_content('Duration cannot be less')
  end

  it 'does not create a new viewing party when duration is blank', :vcr do
    visit new_movie_party_path(@user1, @movie.id)

    fill_in 'Duration of Party (in minutes)', with: "#{@movie.runtime - 1}" 
    click_button 'Create Party'
    expect(page).to have_content('Error')
    expect(page).to have_content('Duration cannot be less')
  end
end
