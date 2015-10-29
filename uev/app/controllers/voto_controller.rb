class VotoController < ApplicationController
    def self.count_votes
        json = {"votação" => {}}
        Cargo.all.each do |_cargo|
            id_cargo = _cargo.ueg
            json["votação"].merge!({"#{id_cargo}" => {}})
            
            candidatos = Candidato.where(ueg: id_cargo)
            candidatos.each do |_candidato|
                number = _candidato.number
                votes  = Voto.where(value: _candidato.number).count
                
                json["votação"]["#{id_cargo}"].merge!({
                    "#{number}" => votes
                })
            end
            
            #fazer
            json["votação"]["#{id_cargo}"].merge!({
                "branco" => 0,
                "nulo" => 0
            })
        end
        
        #Voto.all.delete_all
        json
    end
end
