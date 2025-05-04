class UserSessionsController < ActionController::Base

  def login #google_auth
    # OmniAuth stores info in request.env['omniauth.auth']
    auth = request.env['omniauth.auth']
    user = User.find_or_create_by(email: auth.info.email) do |u|
      u.name = auth.info.name
      u.password = SecureRandom.hex(15) # Random password, not used
    end
    session[:user_id] = user.id
    redirect_to root_path, notice: "Signed in with Google!"
  end
  
  # Logout
  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
  
end