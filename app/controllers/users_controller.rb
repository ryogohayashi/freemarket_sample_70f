class UsersController < ApplicationController
  
  # def index
  #   @user = User.find_by(params[:user_id])
  # end

  def show
    @user = User.where(active: true)
  end

  # private
  #   def user_params
  #     params.require(:user).permit(:title, :memo, :task_id, :order)
  #   end

end
