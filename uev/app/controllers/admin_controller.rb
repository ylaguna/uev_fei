class AdminController < ApplicationController
    
    def initialize
        @user   = nil
        @active = false
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
        else
            puts "nao conectado"
        end
    end
end
