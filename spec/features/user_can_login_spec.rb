require "rails_helper"

RSpec.feature "user logs in" do
  it "lands on welcome page" do
    visit '/'
    
    expect(current_path).to eq('/login_or_sign_up')
    expect(page).to have_link('Sign Up')
    expect(page).to have_link('Login')

  end
  
  it 'will go to links page after log in' do
    user_logs_in
    
    expect(current_path).to eq('/')
    expect(page).to have_content('nate@nate.com')
  end
  
  
  it 'will re render form if login credentials are incorrect' do
    User.create(password: "password", email: "nate@nate.com")
    
    visit '/login'
    fill_in 'email', with: 'bob@bob.com'
    fill_in 'password', with: 'password'
    within('.login-form') do
      click_on 'Login'
    end
    
    expect(current_path).to eq('/login')
  end
end