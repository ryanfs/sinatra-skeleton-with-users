#new
# get sign up page
get '/users/new' do
  erb :"users/new"
end

#create user
post '/users' do
  user = User.new(params)
  user.password = params[:password_hash]
  if user.save
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = user.errors.full_messages
    erb :'users/new'
  end
end

#destroy user
delete "/users/:id" do
 @user = User.find_by(id: params[:id])
  if logged_in? && @user.id == session[:user_id]
    @user.destroy
    redirect "/"
  else
    @no_access = "You do not have access"
    erb :index
  end
end

#edit user
get '/users/:username/edit' do
  @user = User.find_by(username: params[:username])
  if logged_in? && @user.id == session[:user_id]
    erb :'users/edit'
  else
    @no_access = "You do not have access"
    erb :index
  end
end

#update user
put '/users/:id' do
  @user = User.find_by(id: params[:id])
  if logged_in? && @user.id == session[:user_id]
    user = User.find_by(id: params[:id])
    user.update_attributes(params[:user])
    user.save
    redirect '/'
  else
    @no_access = "You do not have access"
    erb :index
  end
end

#show user
get "/users/:username" do
  @user = User.find_by(username: params[:username])
  erb :"/users/show"
end
