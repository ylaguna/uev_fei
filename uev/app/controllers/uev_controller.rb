class UevController < ApplicationController
    def index
        @status = UevConfig.first.status
        
    end
end
