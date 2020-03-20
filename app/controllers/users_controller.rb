class UsersController < ApplicationController
    get '/signup' do 
        erb :"users/new.html"
    end
 
    post '/users' do 
        @user = User.new
        @user.username = params[:username]
        @user.password = params[:password]
        if @user.save
            redirect '/login'
        else 
            erb :"users/new.html"
        end
    end

end

