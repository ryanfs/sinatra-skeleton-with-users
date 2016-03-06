# new session
get '/login' do
  erb :'/sessions/new'
end

#create session
post '/login' do
  user = User.find_by(username: params[:username])
  if user && user.password == params[:password_hash]
    session[:user_id] = user.id
    redirect '/'
  else
    # @error = "Something went wrong. Please try again."
    @errors = user.errors.full_messages
    erb :'/sessions/new'
  end
end

# destroy session
get '/logout' do
  session.clear
  redirect '/'
end
