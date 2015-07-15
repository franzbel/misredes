class UsersController < ApplicationController
  def new
  end

  def show
    @usuario = User.find(params[:id])

  end
end
