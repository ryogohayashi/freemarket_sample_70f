class TopController < ApplicationController
  def index
    @user = User.where(user: current_user)
    @items = Item.limit(3).order('id DESC')
  end

  def show
  end
end
