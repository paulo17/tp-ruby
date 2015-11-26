class PagesController < ApplicationController

  def home
  end

  def about
  end

  def random
    @times = params[:times].to_i unless params[:times].blank?
  end

end
