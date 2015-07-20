class SessionsController < ApplicationController
  def new
  end

  def create
    usuario = User.find_by(email: params[:session][:email].downcase)
    if usuario && usuario.authenticate(params[:session][:password])
      log_in usuario
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user_path(usuario)
    else
      flash.now[:danger] = 'Combinacion invalida de email/password'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end

