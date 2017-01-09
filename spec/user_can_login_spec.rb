require 'rails_helper'

RSpec.feature 'user logs in' do
  it 'will go to links page after log in' do
    User.create(name: "Nate", password: "password", email_address: "nate@nate.com")
    
    visit '/'
    
    expect(page).to have_link('Sign Up')
    expect(page).to have_link('Login')
    
    within('.signup') do 
      click_link 'Login'
    end
    expect(current_path).to eq('/login')
    
    fill_in 'session[email_address]', with: 'nate@nate.com'
    fill_in 'session[password]', with: 'password'
    within('.session') do
      click_on 'Login'
    end
    
    expect(current_path).to eq('/links')
    expect(page).to have_content('Nate')
  end
  
  it 'will redirect to links page if authenticated user' do
    user_logs_in
    visit '/'
    expect(current_path).to eq('/links')
  end
  
  it 'will re render form if login credentials are incorrect' do
    User.create(name: "Nate", password: "password", email_address: "nate@nate.com")
    
    visit '/login'
    fill_in 'session[email_address]', with: 'bob@bob.com'
    fill_in 'session[password]', with: 'password'
    within('.session') do
      click_on 'Login'
    end
    
    expect(current_path).to eq('/login')
  end
end