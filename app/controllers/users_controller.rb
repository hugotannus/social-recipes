class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:edit, :update]
  before_action :correct_user,    only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
  end

  def new
    @user = User.new
    render layout: 'main'
  end

  def create
    @user = User.new(user_params)
    msg = "Parabéns, #{@user.name}! Você criou sua conta no Social Recipes."

    if @user.save
      log_in @user
      flash[:success] = msg
      redirect_to @user
    else
      flash.now[:danger] = 'Erro: não foi possível cadastrar usuário.'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render layout: 'main'
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = 'Perfil atualizado com sucesso!'
      redirect_to @user
    else
      flash.now[:danger] = 'Erro: não foi possível atualizar dados.'
      render :edit
    end
  end

  def recipes; end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :city, :facebook, :twitter,
      :password, :password_confirmation
    )
  end
end
