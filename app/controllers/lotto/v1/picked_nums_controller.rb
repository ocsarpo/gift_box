module Lotto::V1
    class PickedNumsController < ApplicationController
        
        private
        
        def picked_num_params
            params.require(:picked_num).permit(:lotto_number_id, :round)        
        end
    end

end