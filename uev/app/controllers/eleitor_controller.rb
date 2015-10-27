class EleitorController < ApplicationController
     def self.create_list(eleitores)
        eleitores.each do |c|
            Eleitor.create(name: c[:nome], doc: c[:numero_doc])
        end
    end
    
    def self.drop_list
        Eleitor.all.delete_all
    end
end
