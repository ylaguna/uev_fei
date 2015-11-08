class Eleitor < ActiveRecord::Base
    def situation
        return "Votação Pendente" if self.status == 0
        return "Votação já realizada"
    end
    
    def photo
        blank_photo = 'https://d9l6sxvad4fde.cloudfront.net/assets/social/default_avatar-8bd4f2081fdaabcd366b0467edba5172.png'
        return blank_photo if self.photo_url.blank?
        self.photo_url
    end
end
