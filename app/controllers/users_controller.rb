class UsersController < ApplicationController
  def show
    @user = User.find_by(params[:id])
    @nickname = current_user.nickname
  end
end
