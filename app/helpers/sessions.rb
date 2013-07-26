helpers do

  def current_user
    @current_user ||= User.find_by_id(session[:id]) if session[:id]
  end
  
  def login_by_creating_session(user)
    session[:id] = user.id
  end
end
