require 'rails_helper'

RSpec.feature 'user can edit a url' do
  it 'can see the updated url on the index' do
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
    
    link = Link.last
    click_on 'Edit'
    expect(current_path).to eq("/links/#{link.id}/edit")
    fill_in 'link[url_link]', with: 'http://www.nba.com'
    fill_in 'link[title]', with: 'NBA'
    click_on "Update Link"
    
    expect(current_path).to eq('/links')
    expect(page).to have_content('URL: NBA')
    expect(page).to have_content('Read: False')
    expect(page).to have_button('Mark As Read')
    expect(page).to have_button('Edit')
  end
  
  it 'will be redirected to edit form if url not validated' do
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
    
    link = Link.last
    click_on 'Edit'
    expect(current_path).to eq("/links/#{link.id}/edit")
    fill_in 'link[url_link]', with: 'blah'
    fill_in 'link[title]', with: 'NBA'
    click_on "Update Link"
    
    expect(current_path).to eq("/links/#{link.id}")
    expect(page).not_to have_content('URL: NBA')
    expect(page).not_to have_content('Read: False')
    expect(page).not_to have_button('Mark As Read')
    expect(page).not_to have_button('Edit')
  end
end