class V1::LottoNumbersController < ApplicationController
  def index
    @lotto_nums = LottoNumber.all

    render json: @lotto_nums, status: :ok
  end

  def show
    ln = LottoNumber.find_by(id: params[:id])

    render json: ln, status: :ok
  end

  private

  def lotto_num_params
      params.require(:lotto_number).permit(:num, :name)        
  end   
end
