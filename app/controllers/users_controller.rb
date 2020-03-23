class UsersController < ApplicationController

    #signup route 

    get '/signup' do 
        if logged_in?
            "You are already logged in."
            redirect '/logs'
        else 
            erb :"users/new.html"
        end
    end

    post '/signup' do 
        if logged_in?
            "You are already logged in."
            redirect to '/logs'
        elsif params[:username] == "" || params[:password] == ""
            "need a username and password to establish an account"
            redirect to'/signup'
        else 
            @user = User.create(username: params[:username], password: params[:password])
            @user.save 
            session[:username] = @user.username 
            redirect to '/logs'
        end
    end
    
    #login route 
    get '/login' do
        if logged_in?
            "You are already logged in."
            redirect to '/logs'
        else 
            erb :"users/login.html"
        end 
    end 

    post '/login' do 
        login(params[:username], params[:password])
        redirect '/logs'
    end

    #logout route 
    get '/logout' do 
        logout! 
        redirect '/'
    end

end

