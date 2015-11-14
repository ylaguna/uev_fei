class EleitorController < ApplicationController
    skip_before_filter :verify_authenticity_token 
    
    def self.create_list(eleitores)
        eleitores.each do |c|
            Eleitor.create(name: c["nome"], doc: c["numero_doc"], photo_url: nil, status: 0, ueg: nil)
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
        status = Eleitor.find_by_doc(params[:doc]).status
        redirect_to '/eleitor', notice: "denied" if status == 1
        @cargos = Cargo.all
    end
    
    def sendVote
       eleitor = Eleitor.find_by_doc(params[:doc])
        
       Cargo.count.times do |_c|
        idx = _c + 1
        vote = params["candidato_#{idx}"]
        vote = -999 if vote == "nulo"
        vote = -888 if vote.blank?
        
        Voto.create(value: vote, cargo_id: idx)
       end
       
       eleitor.update_attribute(:status, 1)
       
    end
    
    def get_candidato
        if params["number"].blank?
            render json: {
                "name" => "BRANCO",
                "photo" => "http://www.thewrap.com/wp-content/uploads/2013/10/Walter-White-funeral.jpg",
                "status" => 1
            }
        else
            @candidato = Candidato.where(ueg: params["ueg_id"], number: params["number"]).first
            unless @candidato.blank?
                render json: {
                    "name" => @candidato.name,
                    "photo" => @candidato.photo_url,
                    "status" => 1
                }
            else
                render json: { 
                    'name' => 'NULO',
                    "photo" => "",
                    "status" => 99
                }
            end
        end
        
    end
end
