class RecipesController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  LAST_RECIPES_AMOUNT = 20
  MOST_FAVORITES_AMOUNT = 5

  def index
    @recipes = Recipe.order(created_at: :desc).take(LAST_RECIPES_AMOUNT)
    @favorites = Recipe.all.sort_by {
                    |recipe| recipe.followers.count
                  }.reverse.take(MOST_FAVORITES_AMOUNT)
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

  def edit
    @recipe = Recipe.find(params[:id])
    @cuisines = Cuisine.all
    @kinds = Kind.all
  end

  def search
    @recipes = Recipe.all.select { |recipe| recipe.include? params[:search] }

    found_message = "#{@recipes.size} resultado(s) para #{params[:search]}."
    unfound_message = "Nenhum resultado para #{params[:search]}."

    flash[:info] = @recipes.size.positive? ? found_message : unfound_message

    render :index
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

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      flash[:success] = 'Receita atualizada com sucesso!'
      redirect_to @recipe
    else
      @cuisines = Cuisine.all
      @kinds = Kind.all
      flash.now[:notice] = 'Não foi possível atualizar a receita.'
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    flash[:info] = "Receita '#{@recipe.title}' apagada com sucesso!"
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :title, :portions, :prep_time, :difficulty, :ingredients, :directions,
      :cuisine_id, :kind_id, :picture, :user_id
    )
  end

  def correct_user
    @user = Recipe.find(params[:id]).user
    unless current_user? @user
      flash[:danger] = 'Tá mexendo na receita dos outros??? VAZA, maluco!'
      redirect_to root_url
    end
  end
end
