class LinksController < ApplicationController
  before_action :require_login
  
  def index
    @hot_links = Link.hot
  end
end
