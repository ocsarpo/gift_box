module Admin::Lotto

  class PickedNumsController < ApplicationController
    def index
      @picked_nums = PickedNum.all

      render json:@picked_nums, status: :ok
    end

    def create
      @picked_num = PickedNum.new(picked_num_params)
      @picked_num.save

      render json: @picked_num, status: :created, location: admin_picked_nums_path(@picked_num)
    end

    def destroy
        @picked_num = PickedNum.where(id: params[:id]).first
        if @picked_num&.destroy
            head(:ok)
        else
            head(:unprocessable_entity)
        end
    end

    private
      
    def picked_num_params
        params.require(:picked_num).permit(:lotto_number_id, :round_id)
    end
  end
end
