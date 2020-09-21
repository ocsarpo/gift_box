module Lotto::V1
  class RoundsController < ApplicationController
    before_action :set_round, only: [:show]

    # GET /v1/rounds
    def index
      page = params[:page]
      @rounds = Round.page({
        page: page,
        fields: "id, round, draw",
        order_field: "draw",
        order_method: "desc"
      })
      
      render json: @rounds
    end

    # GET /v1/rounds/1
    def show
      @wins_info = wins_info(@v1_round)

      render json: @wins_info
    end

    # GET /v1/rounds/latest
    def latest
      @wins_info = wins_info(Round.last)

      render json: @wins_info
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

      def wins_info(round)
        RoundService.new(round).wins_info
      end
  end
end