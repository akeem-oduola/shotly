class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth.except("extra")
    user = User.sign_in_from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to dashboard_url, notice: "SIGNED IN"
  end

  def destroy
    session[:user_id] = nil
    session[:omniauth] = nil
    redirect_to root_url, notice: "SIGNED OUT"
  end

  def auth_failure
    redirect_to root_path, alert: "Authentication failed, please try again."
  end
end
