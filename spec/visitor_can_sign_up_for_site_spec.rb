require 'rails_helper'

RSpec.feature 'visitor signs up' do
  it 'will go to links page after sign up' do
    visit '/'
    
    expect(page).to have_link('Sign Up')
    expect(page).to have_link('Login')
    
    within('.signup') do 
      click_link 'Sign Up'
    end
    expect(current_path).to eq('/signup')
    
    fill_in 'user[name]', with: 'Nate'
    fill_in 'user[email_address]', with: 'nate@nate.com'
    fill_in 'user[password]', with: 'password'
    
    within('.signup') do
      click_on 'Sign Up'
    end
    
    expect(current_path).to eq('/links')
    expect(page).to have_content('Nate')
  end
  
  it 'will re render sign up page if credentials are not validated' do
    visit '/'
    
    within('.signup') do 
      click_link 'Sign Up'
    end
    
    fill_in 'user[name]', with: 'Nate'
    fill_in 'user[email_address]', with: ''
    fill_in 'user[password]', with: 'password'
    
    within('.signup') do
      click_on 'Sign Up'
    end
    
    expect(current_path).to eq('/signup')
  end
end