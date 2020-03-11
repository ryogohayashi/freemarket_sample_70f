class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @@users = User.all
  end

  def logout
  end

  def ncard
  end

  def scard
  end
  

end
