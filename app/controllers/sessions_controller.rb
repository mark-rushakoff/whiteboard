class SessionsController < ApplicationController
  def create
    session[:logged_in] = true if request.env['omniauth.auth']['info']['email'] =~ /.*@pivotallabs\.com/
    redirect_to '/'
  end

  def require_login
  end
end