class LogsController < ApplicationController
    
    #create 
    get '/logs/new' do  #takes you to the create log page 
        if logged_in? #checking if they are logged in 
            erb :"logs/newlog" #redirecting  if they aren't 
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
        if current_user
            @user = current_user
            @logs = @user.logs.all 
            erb :"logs/index"
        else 
            redirect '/login' #need flash message to state not logged in 
        end  
    end

    get '/logs/:id' do 
        if @log = Log.find_by_id(params[:id]) 
            if @log.user_id == current_user.id
                    erb :"/logs/show"
            else 
                redirect '/logs'
            end 
        else 
            if @log == nil 
                redirect to '/logs'
            end
        end 
    end 

    #update 
    get '/logs/:id/edit' do 
        if logged_in?
            @log = Log.find_by_id(params[:id])
        if @log.user_id == session[:user_id]
            erb :"logs/edit"
        else
            redirect to '/logs' #flash message stating that its not users review
        end
    else 
        '/login' #flash message stating that you aren't logged in. 
    end 
end 

    patch '/logs/:id' do 
        @log = Log.find_by_id(params[:id])
        if params[:date] == "" || params[:creature] == "" || params[:location] == "" || params[:coordinates] == "" || 
           params[:description] == ""  #all fields aren't filled on edit form 
           redirect to '/logs/#{params[:id]}/edit' #flash message: to let user know all fields must be filled
        elsif @log.user_id == session[:user_id]
            @log.date = params[:date]
            @log.creature = params[:creature]
            @log.location = params[:location]
            @log.coordinates = params[:coordinates]
            @log.user_id = current_user.id
            @log.save
            redirect to "/logs/#{@log.id}"
        else  #flash message:log updated, bug may be here 
        end 
    end

    #delete 
    delete '/logs/:id/delete' do 
        if logged_in?
            @log = Log.find_by_id(params[:id])
            if @log.user_id == session[:user_id]
                @log.delete #flash message: log has been deleted
                redirect to '/logs'
            end
        else 
            redirect to '/login' #flash message:not logged in 
        end
    end
end 