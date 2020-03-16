class ItemsController < ApplicationController
  def new
  end

  def create
    Post.create()
  end
end
