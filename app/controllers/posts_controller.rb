class PostsController < ApplicationController


    get '/posts' do 
        "A list of publicly available posts"
    end

    get '/posts/new' do 
        #checking if they are logged in 
        if !logged_in?
            redirect "/login" #redirecting  if they aren't 
        else 
            "A new post form" #rendering if they are 
        end
    end

    get '/posts/:id/edit' do 
        if !logged_in?
            redirect "/login" #redirecting  if they aren't 
        else 
            #how do i find the post that only the author user is allowed to edit 
            if post = current_user.posts.find_by(params[:id])
            "An edit post form #{current_user.id} is editing #{post.id}"
            else
                redirect '/posts'
            end 
        end 
    end
end