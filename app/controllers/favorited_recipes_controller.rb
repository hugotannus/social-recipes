class FavoritedRecipesController < ApplicationController
  before_action :logged_in_user,  only: [:create, :destroy]
  before_action :different_user,  only: [:create]
  before_action :correct_user,    only: [:destroy]

  def create
    @recipe = Recipe.find(params[:favorite_id])
    # @mark = FavoritedRecipe.new(mark_params)

    unless current_user.favorites << @recipe
      flash.now[:danger] = "Ocorreu um erro ao tentar adicionar #{@recipe.title}"
    end

    redirect_to recipe_url(@recipe)
  end

  def destroy
    @favorited = FavoritedRecipe.find(params[:id])
    @recipe    = @favorited.favorite

    unless FavoritedRecipe.delete(@favorited)
      flash.now[:danger] = "Ocorreu um erro ao tentar desmarcar #{@recipe.title}"
    end

    redirect_to recipe_url(@recipe)
  end

  private

  def different_user
    @recipe = Recipe.find(params[:favorite_id])
    @user = @recipe.user;
    if current_user? @user
      flash[:danger] = 'Algo está errado... Você não deveria poder favoritar as próprias receitas'
      redirect_to recipe_url(@recipe)
    end
  end

  def correct_user
    @follower = FavoritedRecipe.find(params[:id]).follower
    unless current_user? @follower
      flash[:danger] = 'Algo está errado... Você não deveria poder desmarcar uma receita que não está entre as suas favoritas'
      redirect_to recipe_url(@recipe)
    end
  end

end
