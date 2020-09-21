module Lotto::V1
  class LottoNumbersController < ApplicationController
    def index
      @lotto_nums = LottoNumber.all

      render json: @lotto_nums, status: :ok
    end

    def show
      ln = LottoNumber.find_by(id: params[:id])    

      render json: details(ln), status: :ok
    end

    private

    def lotto_num_params
        params.require(:lotto_number).permit(:num, :name)        
    end

    def details(ln)
      LottoNumberService.new(ln).details
    end
  end
end