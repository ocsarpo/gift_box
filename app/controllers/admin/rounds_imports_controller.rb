class Admin::RoundsImportsController < ApplicationController
  # GET /admin/rounds_imports/new
  def new
    @rounds_import = RoundsImport.new

    render json: @rounds_import
  end

  # POST /admin/rounds_imports
  def create
    @rounds_import = RoundsImport.new(params[:rounds_import])
    if @rounds_import.save
      render json: "{}", status: :created, location: admin_rounds_path
    else
      render json: @rounds_import.errors, status: :unprocessable_entity
    end
  end
end
