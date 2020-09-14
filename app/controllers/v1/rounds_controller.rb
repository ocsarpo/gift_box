class V1::RoundsController < ApplicationController
  before_action :set_round, only: [:show]

  # GET /v1/rounds
  def index
    @v1_rounds = Round.all

    render json: @v1_rounds
  end

  # GET /v1/rounds/1
  def show
    render json: @v1_round
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @v1_round = Round.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def round_params
      params.fetch(:round, {})
    end
end
