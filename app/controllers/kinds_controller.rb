class KindsController < ApplicationController

  def show
    @kind = Kind.find(params[:id])
  end

  def new
    @kind = Kind.new
  end

  def create
    @kind = Kind.new(kind_params)

    if @kind.save
      redirect_to @kind
    else
      flash[:notice] = 'Não foi possível criar o tipo de receita.'
      render :new
    end

  end

  private

  def kind_params
    params.require(:kind).permit(:name)
  end

end
