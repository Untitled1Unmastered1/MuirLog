class SessionsController < ApplicationController 

    get '/' do
        
    end

    get '/login' do
        erb :"sessions/login.html"
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
end
