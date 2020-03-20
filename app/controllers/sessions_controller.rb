class SessionsController < ApplicationController 

    get '/login' do
        erb :"sessions/login.html"
    end 

    post '/sessions' do 
        #login a user with this email 
        login(params[:email], params[:password])
        redirect '/posts'
    end

    get '/logout' do 
        logout! 
        redirect '/posts'
    end
end
