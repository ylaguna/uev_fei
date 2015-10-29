class EleitorController < ApplicationController
    def self.create_list(eleitores)
        eleitores.each do |c|
            Eleitor.create(name: c[:nome], doc: c[:numero_doc], photo_url: nil, status: 0, ueg: nil)
        end
    end
    
    def self.drop_list
        Eleitor.all.delete_all
    end
end
