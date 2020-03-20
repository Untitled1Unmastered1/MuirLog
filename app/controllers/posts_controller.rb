class LogsController < ApplicationController


    get '/logs' do 
        "A list of publicly available logs"
    end

    get '/logs/new' do 
        #checking if they are logged in 
        if !logged_in?
            redirect "/login" #redirecting  if they aren't 
        else 
            "A new log form" #rendering if they are 
        end
    end

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