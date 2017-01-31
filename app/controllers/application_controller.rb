class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def show
    @kinds = Kind.all
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'Oops! Parece que você não está logado...'
      redirect_to login_url
    end
  end
end
