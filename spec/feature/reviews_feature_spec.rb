require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC' }

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'display an average rating for all reviews' do
    sign_up
    leave_review("Okay", '3')
    click_link "Sign out"
    sign_up("test2@email.com", "2938472")
    leave_review("Brilliant", '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end
end
