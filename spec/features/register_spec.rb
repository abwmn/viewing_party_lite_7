require 'rails_helper'

feature "User registration" do
  before(:each) do
    visit new_user_path
  end

  scenario "User registers and is taken to their dashboard" do
    fill_in "Name", with: "Snoop Dogg"
    fill_in "Email", with: "snoop@dogg.com"
    click_button "Register"

    user = User.find_by(email: "snoop@dogg.com")

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Snoop Dogg's Dashboard")
    expect(page).to have_content("My Parties")
  end

  feature "User fails to register" do
    scenario "User tries to register without a name" do
      fill_in "Email", with: "snoop@dogg.com"
      click_button "Register"
      expect(page).to have_content("Name can't be blank")
    end

    scenario "User tries to register without an email" do
      fill_in "Name", with: "Snoop Dogg"
      click_button "Register"
      expect(page).to have_content("Email can't be blank")
    end

    scenario "User tries to register with an email that's already taken" do
      User.create!(name: "Snoop Dogg", email: "snoop@dogg.com")
      fill_in "Name", with: "Snoop Dogg"
      fill_in "Email", with: "snoop@dogg.com"
      click_button "Register"
      expect(page).to have_content("Email has already been taken")
    end
  end
end