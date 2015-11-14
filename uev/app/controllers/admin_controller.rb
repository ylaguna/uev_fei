class AdminController < ApplicationController
    skip_before_filter :verify_authenticity_token 
    
    def initialize
        @user   = nil
        @active = false
        @ueg = UegConnection.new
    end
   
    def conn(user, pass)
        search = Admin.where(user: user, pass: pass)
        return "not_accessible" if search.blank?
        
        @user   = search.first
        @active = true
        
       # inicializa
        
        return "ok"
    end
    
    def inicializa
        @ueg = UegConnection.new
        @ueg.inicializa
            
        puts "ueg inicializada"
       
    end
    
    def finaliza
        @ueg = UegConnection.new
        @ueg.finaliza
    end
    
    def index 
        initialize
    end
    
    def login
        user =  params["admin"]["username"]
        pass =  params["admin"]["password"]
        
        conn = conn(user, pass)
        if conn == 'ok'
            @status_uev = UevConfig.first.status
        else
            respond_to do |format|
                format.html { render :text => conn  }
            end
        end
    end
    
    def iteract
        params["status"].to_i == -1 ? inicializa : finaliza
        render json: ['ok']
    end
end
