class CandidatoController < ApplicationController
    def self.create_list(candidatos)
        candidatos.each do |c|
            Candidato.create(name: c["nome"], nickname: c["apelido"], number: c["numero"], photo_url: c["foto"], ueg: c["id_cargo"])
        end
    end
    
    def self.drop_list
        Candidato.all.delete_all
    end
end
