class User < ActiveRecord::Base
    has_secure_password 

    validates :username, uniqueness: true 
    
    has_many :logs  
end

#this adds methods to my instances
#adds password= 
#password_confirmation
#user.authenticate 

