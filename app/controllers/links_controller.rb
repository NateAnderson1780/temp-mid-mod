class LinksController < ApplicationController
  def index
    @link = Link.new
    @links = Link.all
  end
  
  def create
    @link = Link.new(link_params)
    if @link.save
      current_user.links << @link
      redirect :back
    else
      redirect :back
    end
  end
  
  private
  
  def link_params
    params.require(:link).permit(:url, :title)
  end
end
