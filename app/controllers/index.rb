get '/' do
  @users = User.all
  # render home page
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  @user = User.new
  @error = nil
  
  # render sign-in page 
  erb :sign_in
end 

post '/sessions' do
  # sign-in
  @user = User.find_by_email(params[:email])
  
  if @user.password == params[:password]
    login_by_creating_session(@user)
    redirect '/'
  else
    @error = "your account info is incorrect"
    erb :sign_in
  end
end

delete '/sessions/:id' do
  session.clear
  # sign-out -- invoked via AJAX
  # redirect '/'
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  user = User.new(name: params[:user][:name], email: params[:user][:email])
  user.password = params[:user][:password]
  user.save
  
  login_by_creating_session(user)
  
  redirect '/'
end
