require "rails_helper"

RSpec.describe "can create links", :js => :true do
  scenario "Create a new link" do
    user_logs_in
    fill_in "link-title", :with => "Turing"
    fill_in "link-url", :with => "http://turing.io"
    click_on "Add Link"

    within('#links-list') do
      expect(page).to have_text("Turing")
      expect(page).to have_text("http://turing.io")
    end
  end
  
  scenario "Create an invalid link" do
    user_logs_in
    fill_in "link-title", :with => "Turing"
    fill_in "link-url", :with => "blah"
    click_on "Add Link"
    
    within('#links-list') do
      expect(page).not_to have_text("Turing")
    end
  end
  
  scenario "can update links" do
    user_logs_in
    fill_in "link-title", :with => "Turing"
    fill_in "link-url", :with => "http://turing.io"
    click_on "Add Link"
    
    click_on "Edit"
    fill_in "link-title", :with => "ESPN"
    fill_in "link-url", :with => "http://www.espn.com"
    
    click_on "updateLink"
    within('#links-list') do
      expect(page).to have_text("ESPN")
    end
  end
  
  scenario "can not update links with invalid email" do
    user_logs_in
    fill_in "link-title", :with => "Turing"
    fill_in "link-url", :with => "http://turing.io"
    click_on "Add Link"
    
    click_on "Edit"
    fill_in "link-title", :with => "ESPN"
    fill_in "link-url", :with => "blah"
    
    click_on "updateLink"
    within('#links-list') do
      expect(page).not_to have_text("ESPN")
    end
  end
  
  scenario "can delete links" do
    user_logs_in
    fill_in "link-title", :with => "Turing"
    fill_in "link-url", :with => "http://turing.io"
    click_on "Add Link"
    
    click_on "Delete"
    within('#links-list') do
      expect(page).not_to have_text("Turing")
    end
  end
end
