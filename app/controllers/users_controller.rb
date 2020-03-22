class UsersController < ApplicationController
    get '/signup' do 
        erb :"users/new.html"
    end

    get '/login' do
        erb :"users/login.html"
    end 

    post '/sessions' do 
        #login a user with this email 
        login(params[:username], params[:password])
        redirect '/logs'
    end

    get '/logout' do 
        logout! 
        redirect '/logs'
    end
 
    post '/users' do 
        @user = User.new
        @user.username = params[:username]
        @user.password = params[:password]
        if @user.save
            redirect '/logs'
        else 
            erb :"users/new.html"
        end
    end

end

