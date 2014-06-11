require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'
require 'pry'

require_relative 'app_methods'
require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

get '/' do
  @meetups = list_of_meetups
  erb :index
end

get '/new_meetup' do
  @meetup = Meetup.new()
  erb :new_meetup
end

post '/new_meetup' do
  @user_id = session[:user_id]
  @meetup = Meetup.new()
  @meetup.name = params["name"]
  @meetup.description = params["description"]
  @meetup.location = params["location"]
  attendee = Attendee.new()
  attendee.user_id = @user_id
  attendee.meetup_id = @meetup.id
  attendee.creator = true

  if @user_id != nil
    @meetup.save
    attendee.save
    flash[:notice] = "Your meetup was succesfully created"
    redirect "/meetups/#{meetup.id}"
  else
    flash[:notice] = 'You need to sign in if you want to do that!'
    erb :new_meetup
  end
end

post '/join_meetup' do
  @user_id = session[:user_id]
  if @user_id == nil
    authenticate!
    erb :meetup
  else
    attendee = Attendee.new()
    attendee.user_id = @user_id
    attendee.meetup_id = params["meetup_id"]
    attendee.creator = false
    redirect "/meetups/#{attendee.meetup_id}"
  end
end

get '/meetups/:id' do
  @user_id = session[:user_id]
  meetup_id = params[:id]
  @meetup = Meetup.find(meetup_id)
  erb :meetup
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end
