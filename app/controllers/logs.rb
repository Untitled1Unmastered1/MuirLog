class LogsController < ApplicationController
    
    #create 
    get '/logs/new' do 
        #checking if they are logged in 
        if logged_in?
            erb :"logs/newlog.html" #redirecting  if they aren't 
        else 
            redirect '/login' #rendering if they are 
        end
    end

    #read 
    get '/logs' do 
        if logged_in?
            @user = current_user
            @logs = @user.logs.all 
            erb :"logs/index.html"
        else 
            "Oops! Looks like you're not logged in. Try again."
            redirect '/login'
        end 
        #this method should render the homepage and a feed of other users logs. if you have a log as well it should display
        #it on the feed above others' logs 
    end

    #update 
    get '/logs/:id/edit' do 
        if !logged_in?
            redirect "/login" #redirecting  if they aren't 
        else 
            #how do i find the post that only the author user is allowed to edit 
            if log = current_user.logs.find_by(params[:id])
            "An edit log form #{current_user.id} is editing #{log.id}"
            else
                redirect '/logs'
            end 
        end 
    end 
end 