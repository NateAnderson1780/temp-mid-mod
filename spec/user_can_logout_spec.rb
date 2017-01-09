require 'rails_helper'

RSpec.feature 'user can logout' do
  it 'will redirect to login page' do
    user_logs_in
    
    click_on 'Logout'
    
    expect(current_path).to eq('/login')
  end
end