class TopController < ApplicationController
  def index
    @user = User.where(user: current_user)
  end
end
