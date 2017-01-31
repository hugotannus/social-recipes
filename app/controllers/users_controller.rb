class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:edit, :update]
  before_action :correct_user,    only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes

    @kinds = Kind.all
    @cuisines = Cuisine.all
  end

  def new
    @user = User.new
    render layout: 'main'
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

  def edit
    @user = User.find(params[:id])
    render layout: 'main'
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Perfil atualizado com sucesso!"
      redirect_to @user
    else
      flash.now[:danger] = 'Erro: não foi possível atualizar dados.'
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(
        :name, :email, :city, :facebook, :twitter,
        :password, :password_confirmation
      )
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = 'Oops! Parece que você não está logado...'
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user? @user
        flash[:danger] = 'O que você pensa que está fazendo??? VAZA, maluco!!!'
        redirect_to root_url
      end
    end
end
