class UegConnection
    def initialize
        @conn = false
        @json = nil
        @url_get  = "http://52.23.228.201/index.php/solicitaDados"
        @url_send = "http://52.23.228.201/index.php/enviaVotacao"
        @params = { "senha" => "uev3" }
    end
    
    def inicializa
        conn
        if @conn
            populaUev
        else
            puts "Não foi possível conectar com a UEG"
        end
    end
    
    def finaliza
        ret = sendData(get_data)
        if ret.to_s == "OK" then
            puts "SUCESSO"
            puts "Finalizando Conexão"
            destroyAll
        else
            puts "OCORREU UM ERRO NO ENVIO DOS DADOS"
        end
    end
    
   
    private
    
    def conn
        #conexao com a uev
        ret = HTTParty.post(@url_get, 
            :body =>  @params.to_json,  
            :headers => { 'Content-Type' => 'application/json', 'charset' => 'UTF-8'})
        
        
        @json = JSON.parse(ret.parsed_response)
        
        if true
            @conn = true
            #@json = retTeste
        end
    end
    
    
    def get_data
        params = VotoController.count_votes.merge(@params)
        params.merge!(EleitorController.away_list)
        params
    end
    
    def sendData(json)
       HTTParty.post(@url_send, :body => get_data.to_json, :headers => { 'Content-Type' => 'application/json' })
    end
    
    def populaUev
        puts "Populando UEV"
        CargoController.create_list(@json["cargos"])
        CandidatoController.create_list(@json["candidatos"])
        EleitorController.create_list(@json["eleitores"])
        UevConfig.first.update_attribute(:status , 1)
    end
    
    def destroyAll
        puts "Destruir legal o/"
        EleitorController.drop_list
        CandidatoController.drop_list
        CargoController.drop_list
        UevConfig.first.update_attribute(:status , -1)
    end
    
    def retTeste
        {:cargos=>[{:id=>"1", :nome=>"Presidente"}, {:id=>"2", :nome=>"Governador"}, {:id=>"3", :nome=>"Prefeito"}, {:id=>"4", :nome=>"Dep. Federal"}, {:id=>"5", :nome=>"Dep. Estadual"}], :candidatos=>[{:numero=>"1", :nome=>"TesteCandidato3", :apelido=>"apelidoCandidato3", :foto=>"url da foto", :id_cargo=>"1"}, {:numero=>"2", :nome=>"Presidente2", :apelido=>"Apelido Presidente2", :foto=>"url da foto", :id_cargo=>"1"}, {:numero=>"3", :nome=>"Presidente3", :apelido=>"Apelido Presidente3", :foto=>"url da foto", :id_cargo=>"1"}, {:numero=>"4", :nome=>"Presidente4", :apelido=>"Apelido Presidente4", :foto=>"url da foto", :id_cargo=>"1"}, {:numero=>"5", :nome=>"Presidente5", :apelido=>"Apelido Presidente5", :foto=>"url da foto", :id_cargo=>"1"}, {:numero=>"11", :nome=>"Governador11", :apelido=>"Apelido Governador11", :foto=>"url da foto", :id_cargo=>"2"}, {:numero=>"12", :nome=>"Governador12", :apelido=>"Apelido Governador12", :foto=>"url da foto", :id_cargo=>"2"}, {:numero=>"22", :nome=>"Governador22", :apelido=>"Apelido Governador22", :foto=>"url da foto", :id_cargo=>"2"}, {:numero=>"111", :nome=>"Prefeito 111", :apelido=>"Apelido Prefeito111", :foto=>"url da foto", :id_cargo=>"3"}, {:numero=>"222", :nome=>"Prefeito 222", :apelido=>"Apelido Prefeito222", :foto=>"url da foto", :id_cargo=>"3"}, {:numero=>"1111", :nome=>"Dep. 1111", :apelido=>"Apelido Dep. 1111", :foto=>"url da foto", :id_cargo=>"4"}, {:numero=>"2222", :nome=>"Dep. 2222", :apelido=>"Apelido Dep. 2222", :foto=>"url da foto", :id_cargo=>"4"}, {:numero=>"11111", :nome=>"Dep. 11111", :apelido=>"Apelido Dep. 11111", :foto=>"url da foto", :id_cargo=>"5"}, {:numero=>"22222", :nome=>"Dep. 22222", :apelido=>"Apelido Dep. 22222", :foto=>"url da foto", :id_cargo=>"5"}], :eleitores=>[{:numero_doc=>"1", :nome=>"NomeEleitor1"}, {:numero_doc=>"2", :nome=>"NomeEleitor2"}, {:numero_doc=>"3", :nome=>"NomeEleitor3"}], :tempo_expiracao=>55} 
    end
    
end