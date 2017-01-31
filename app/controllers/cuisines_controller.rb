class CuisinesController < ApplicationController

  def show
    @cuisine = Cuisine.find(params[:id])
    @recipes = @cuisine.recipes

    @cuisines = Cuisine.all
    @kinds = Kind.all
  end

  def new
    @cuisine = Cuisine.new
    render layout: 'main'
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)

    if @cuisine.save
      redirect_to @cuisine
    else
      flash[:notice] = 'Não foi possível criar a cozinha.'
      render :new
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end

end
