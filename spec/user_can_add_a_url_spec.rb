require 'rails_helper'

RSpec.feature 'user can add a url' do
  it 'can see the url on the index' do
    user_logs_in
    
    expect(current_path).to eq('/links')
    fill_in 'link[url_link]', with: 'http://www.espn.com'
    fill_in 'link[title]', with: 'ESPN'
    click_on "Submit Link"
    
    expect(current_path).to eq('/links')
    expect(page).to have_content('URL: ESPN')
    expect(page).to have_content('Read: False')
    expect(page).to have_button('Mark As Read')
    expect(page).to have_button('Edit')
  end
  
  it 'can not add a url that fails validation' do
    user_logs_in
    
    expect(current_path).to eq('/links')
    fill_in 'link[url_link]', with: 'blah'
    fill_in 'link[title]', with: 'ESPN'
    click_on 'Submit Link'
    
    expect(page).not_to have_content('URL: ESPN')
    expect(page).not_to have_content('Read: False')
    expect(page).not_to have_button('Mark As Read')
    expect(page).not_to have_button('Edit')
    
    
  end
end