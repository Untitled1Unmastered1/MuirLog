class User < ActiveRecord::Base
    has_secure_password 

    validates :email, :presence => true 
    
    has_many :posts 
end

#this adds methods to my instances
#adds password= 
#password_confirmation
#user.authenticate 

