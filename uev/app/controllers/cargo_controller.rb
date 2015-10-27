class CargoController < ApplicationController
    def self.create_list(cargos)
        cargos.each do |c|
            Cargo.create(name: c[:nome], ueg: c[:id])
        end
    end
    
    def self.drop_list
        Cargo.all.delete_all
    end
end




