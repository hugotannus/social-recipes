class UsersController < ApplicationController

  def show
    @user = User.find(params[:id]) || current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # debugger

    if @user.save
      log_in @user
      flash[:success] = "Parabéns, #{@user.name}! Você acaba de criar sua conta no Social Recipes."
      redirect_to @user
    else
      flash.now[:danger] = 'Erro: não foi possível cadastrar usuário.'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation
    )
  end
end
