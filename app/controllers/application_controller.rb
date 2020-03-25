require './config/environment'

class ApplicationController < Sinatra::Base 

    configure do 
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "johnmuir"
    end

    #if i comment out lines 6 and 7, i will not have any cookies. why? bc if i start up a sinatra app and turn sessions 
    #off, my app is not issuing the browser a cookie. a cookie is like a receipt, everyone that goes to my website is being
    #issued a secret key, that corresponds to a session on my server. 

    #home
    get '/' do 
        erb :"logs/home.html"
    end
 
    
    helpers do 

        def logged_in?
            !!current_user  
        end 

        #A helper method is a method written for the view, it's designed to be reusable anywhere within the website, and 
         # it cleans up the view code by separating out some logic.

        # the first time you called logged_in? in the context of a request, i call current_user. if i was able to log you 
        #in bc in your session i found an email, and i can find a user by that email, and i can set that object to an 
        #instance variable called @current_user, this method(logged_in?) will return true. by the time i make it to posts_
        #controller on line 23, i only fired one sql query to find the user. 

        #breakdown of request cycle: on posts_controller i call logged_in? on line 18, which calls logged_in? in the 
        #helpers section of appcontroller, which triggers current_user, which finds the currently logged in user and 
        #then when i call current_user on the helper methods, the method returns an instancer of the user set by line 
        #18 of the posts_controller. 

        def current_user
            @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
        end 

        #add helper method to use flash error messages. and make sure to render an erb file, which will display the error
        #messages, use a conditional within the erb file. @user = User.find_by(params) if user.valid redirect to home page
        # user.errors = "stringwhatever errors are" add a key value pair to the hash. if user.errors.any? render this 
        #error message, multiple conditionals for different error messages. 

        #whatever instances are on one page, once refreshed/ redirected these objects dissapears. but if i render,
        #they're still existent. render is preferred, over redirecting. 


        def logout!
            session.clear 
        end
    end 

    #in ruby there are no methods where you can ask if an object is true or false, however if  we double negate something
    #i.e. use 2 boolean operators(!!) it will esentially be the same. 
end 