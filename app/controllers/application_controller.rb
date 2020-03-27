require './config/environment'

class ApplicationController < Sinatra::Base 

    configure do 
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "johnmuir"
    end

    #home
    get '/' do 
        erb :"logs/home"
    end
 
    
    helpers do 

        def logged_in?
            !!current_user  
        end 

        def current_user
            @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
        end 



        def logout!
            session.clear 
        end
    end 
    #in ruby there are no methods where you can ask if an object is true or false, however if  we double negate something
    #i.e. use 2 boolean operators(!!) it will esentially be the same. 
end 