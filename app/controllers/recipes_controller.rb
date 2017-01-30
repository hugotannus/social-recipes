class RecipesController < ApplicationController
  LAST_RECIPES_AMOUNT = 20

  def index
    @cuisines = Cuisine.all
    @recipes = Recipe.order(created_at: :desc).take(LAST_RECIPES_AMOUNT)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @cuisines = Cuisine.all
    @kinds = Kind.all
  end

  def create
    @recipe = Recipe.new(recipe_params)

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
      :cuisine_id, :kind_id, :picture
    )
  end

end
