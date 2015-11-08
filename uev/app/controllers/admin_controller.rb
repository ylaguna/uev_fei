class AdminController < ApplicationController
    
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
        return "ok"
    end
    
    def inicializa
        if @active
            puts "o usuario #{@user.user} deseja comecar uma conexao"
            
            @ueg.inicializa
            
            puts "ueg inicializada"
        else
            puts "nao conectado"
        end
    end
    
    def finaliza
        if @active
            @ueg.finaliza
        else
            puts "nao conectado"
        end
    end
    
    def index 
        initialize
    end
    
    def login
        user =  params["admin"]["username"]
        pass =  params["admin"]["password"]
        
        conn = conn(user, pass)
        if conn == 'ok'
            UevConfig.first.update_attribute(:status , 1)
        else
            UevConfig.first.update_attribute(:status, -1)
        end
        
       
        respond_to do |format|
            format.html { render :text => conn  }
        end
    end
    
    def painel
        @status = UevConfig.first.status
    end
end
