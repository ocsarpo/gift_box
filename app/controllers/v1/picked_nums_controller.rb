class V1::PickedNumsController < ApplicationController
    def index
        @picked_nums = PickedNum.all

        render json:@picked_nums, status: :ok
    end
    
    private
    
    def picked_num_params
        params.require(:picked_num).permit(:lotto_number_id, :round)        
    end
end
