module Lotto::V1
  class DrawsController < ApplicationController
    before_action :set_service, only: [:draw, :random]

    def draw
      @draw = @service.draw

      render json: @draw, status: :ok
    end

    def random
      @draw = @service.random

      render json: @draw, status: :ok
    end

    private
      def set_service
        @service = DrawService.new
      end
  end
end