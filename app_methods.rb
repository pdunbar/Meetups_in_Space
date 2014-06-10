def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

def list_of_meetups
  meetups = Meetup.all()
  meetups = meetups.sort_by{|meetup| meetup.name}
  return meetups
end
