class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user

      flash[:success] = "Seja bem-vind@, #{user.name}!"
      redirect_to current_user
    else
      flash.now[:danger] = 'Usuário e/ou senha inválido(s).'
      render :new
    end
  end

  def destroy
    user_name = current_user.name
    flash[:info] = "Até mais, #{user_name}! Volte sempre :-)"

    log_out
    redirect_to root_path
  end

end
