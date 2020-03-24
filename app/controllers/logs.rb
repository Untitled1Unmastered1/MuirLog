class LogsController < ApplicationController
    
    #create 
    get '/logs/new' do  #takes you to the create log page 
        if logged_in? #checking if they are logged in 
            erb :"logs/newlog.html" #redirecting  if they aren't 
        else 
            redirect '/login' #rendering if they aren't, need to add flash message here 
        end
    end

    post '/logs' do 
        if params[:date] == "" || params[:creature] == "" || params[:location] == "" || params[:coordinates] == "" || 
            params[:description] == "" #want a flash error message here 
            redirect to '/logs/new'
        else 
            user = current_user
            @log = Log.create(
                :date => params[:date],
                :creature => params[:creature],
                :location => params[:location],
                :coordinates => params[:coordinates],
                :description => params[:description],
                :user_id => user.id)
                redirect to "logs/#{@log.id}"
        end 
    end

    #read 
    get '/logs' do 
        if logged_in?
            @user = current_user
            @logs = @user.logs.all 
            erb :"logs/index.html"
        else 
            redirect '/login' #need flash message to state not logged in 
        end 
        #this method should render the homepage and a feed of other users logs. if you have a log as well it should display
        #it on the feed above others' logs 
    end

    get '/logs/:id' do 
        if logged_in?
            @log = Log.find_by_id(params[:id])
            if @log.user_id == session[:user_id]
                erb :"/logs/show.html"
            elsif @log.user_id != session[:user_id] #or username? 
                redirect '/logs'
            end
        else 
            redirect '/logs' #need flash message to state you werent logged in 
        end
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