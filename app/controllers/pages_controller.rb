class PagesController < ApplicationController
  def home
    @title = "Biojotter - Home"
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])

    end
  end

  def contact
    @title = "Biojotter - Contact"
  end

  def about
    @title = "Biojotter - About"
  end

  def help
    @title = "Biojotter - Help"
  end

end
