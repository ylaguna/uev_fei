class EleitorController < ApplicationController
    def self.create_list(eleitores)
        eleitores.each do |c|
            Eleitor.create(name: c[:nome], doc: c[:numero_doc], photo_url: nil, status: 0, ueg: nil)
        end
    end
    
    def self.drop_list
        Eleitor.all.delete_all
    end
    
    def self.away_list
        arr = Eleitor.where(status: 0).select(:doc).map do |_eleitor| _eleitor.doc end
        {"ausentes" => arr}
    end
    
    def index
    end
    
    def profile
        doc = params["doc"]
        @eleitor = Eleitor.find_by_doc doc
        
        unless @eleitor.nil?
            ##
        else
            flash.notice = "Não foi encontrado nenhum eleitor com o documento #{doc}"
            redirect_to '/eleitor'
        end
    end
    
    def vote
        @cargos = Cargo.all
    end
    
    def get_candidato
        @candidato = Candidato.where(ueg: params["ueg_id"], number: params["number"]).first
        unless @candidato.blank?
            render json: {
                "name" => @candidato.name,
                "photo" => @candidato.photo_url
            }
        else
            render json: 'not_found'
        end
    end
end
