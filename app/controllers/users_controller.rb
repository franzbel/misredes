class UsersController < ApplicationController
  def new
    @usuario = User.new
  end

  def show
    @usuario = User.find(params[:id])
  end

  def create
    @usuario = User.new(user_params)
    if @usuario.save
      redirect_to user_path(@usuario)
    else
      render :new
    end
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
