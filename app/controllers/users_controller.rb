class UsersController < ApplicationController

    #signup route 
    get '/signup' do 
        if logged_in?
            "You are already logged in."
            redirect '/logs'
        else 
            erb :"users/new"
        end
    end

    post '/signup' do 
        if params[:username] == "" || params[:password] == ""
            redirect to '/signup'
        else 
            @user = User.new(username: params[:username], password: params[:password])
            if @user.valid? 
                @user.save 
                session[:user_id] = @user.id 
                redirect to '/logs'
            else 
                redirect to '/signup'
            end
        end
    end

    
    #login route 
    get '/login' do
        if logged_in?
            redirect to '/logs' #flash message to say "You are already logged in."
        else 
            erb :"users/login"
        end 
    end 

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id  
            redirect '/logs'
        else 
            redirect '/login' #flash message to say "Your username or password were not correct. Please try again."
        end
    end

    get '/profile' do
        if logged_in?
             @logs = current_user.logs.all 
             erb :"users/logs"
        else 
            redirect '/login' #flash message to please login to view logs
        end 
    end

    #logout route 
    get '/logout' do 
        logout! 
        redirect '/'
    end
end

