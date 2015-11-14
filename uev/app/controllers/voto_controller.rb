class VotoController < ApplicationController
    def self.count_votes
        json = {"votacao" => {}}
        Cargo.all.each do |_cargo|
            id_cargo = _cargo.ueg
            json["votacao"].merge!({"#{id_cargo}" => {}})
            
            candidatos = Candidato.where(ueg: id_cargo)
            candidatos.each do |_candidato|
                number = _candidato.number
                votes  = Voto.where(value: _candidato.number).count
                
                json["votacao"]["#{id_cargo}"].merge!({
                    "#{number}" => votes
                })
            end
            
            
            
            json["votacao"]["#{id_cargo}"].merge!({
                "branco" => Voto.where(value: -888, cargo_id: id_cargo).count,
                "nulo" => Voto.where(value: -999, cargo_id: id_cargo).count
            })
        end
        
        #Voto.all.delete_all
        json
    end
end
