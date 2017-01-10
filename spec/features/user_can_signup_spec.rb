require 'rails_helper'

RSpec.describe "new user can sign up for site" do
  scenario "they will be taken to sign up page" do
    visit '/'
    
    expect(current_path).to eq('/login_or_sign_up')
    within ('.signup') do
      click_on "Sign Up"
    end
    
    fill_in "user[email]", with: "nate@nate.com"
    fill_in "user[password]", with: "nate"
    fill_in "user[password_confirmation]", with: "nate"
    click_on "Submit"
    
    expect(current_path).to eq('/')
  end
  
  scenario "can not sign up with invalid credentials" do
    visit '/'
    
    within ('.signup') do
      click_on "Sign Up"
    end
    
    fill_in "user[email]", with: ""
    fill_in "user[password]", with: "nate"
    fill_in "user[password_confirmation]", with: "nate"
    click_on "Submit"
    
    expect(current_path).to eq('/signup')
  end
end