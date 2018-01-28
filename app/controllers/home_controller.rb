class HomeController < ApplicationController
  def index
    @entries = current_user.entries.includes(:category)
    @categories = current_user.categories
  end
end
