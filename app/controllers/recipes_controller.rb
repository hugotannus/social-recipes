class RecipesController < ApplicationController
  LAST_RECIPES_AMOUNT = 20

  def index
    @cuisines = Cuisine.all
    @kinds = Kind.all
    @recipes = Recipe.order(created_at: :desc).take(LAST_RECIPES_AMOUNT)
  end

  def show
    @recipe = Recipe.find(params[:id])

    @kinds = Kind.all
    @cuisines = Cuisine.all
  end

  def new
    @recipe = current_user.recipes.build if logged_in?
    @cuisines = Cuisine.all
    @kinds = Kind.all

    render layout: 'main'
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to @recipe
    else
      @cuisines = Cuisine.all
      @kinds = Kind.all
      flash.now[:notice] = 'Não foi possível criar a receita.'
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :title, :portions, :prep_time, :difficulty, :ingredients, :directions,
      :cuisine_id, :kind_id, :picture, :user_id
    )
  end

end
