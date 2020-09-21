module Admin::Lotto
  class RoundsController < ApplicationController
    before_action :set_round, only: [:show, :update, :destroy]

    # GET /admin/rounds
    def index
      @admin_rounds = Round.all

      render json: @admin_rounds
    end

    # GET /admin/rounds/1
    def show
      render json: @admin_round
    end

    # POST /admin/rounds
    def create
      @admin_round = Round.new(round_params)

      if @admin_round.save
        render json: @admin_round, status: :created, location: admin_round_path(@admin_round)
      else
        render json: @admin_round.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /admin/rounds/1
    def update
      if @admin_round.update(round_params)
        render json: @admin_round
      else
        render json: @admin_round.errors, status: :unprocessable_entity
      end
    end

    # DELETE /admin/rounds/1
    def destroy
      @admin_round.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_round
        @admin_round = Round.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def round_params
        params.require(:round).permit(:round, :draw)        
      end
  end
end