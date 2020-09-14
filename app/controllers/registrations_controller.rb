class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # POST /v1/signup
  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end
  
private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
