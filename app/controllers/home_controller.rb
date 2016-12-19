class HomeController < ApplicationController
  def index
    if current_user
      redirect_to links_path
    else
      redirect_to welcome_path
    end
  end
end