class Api::V1::AuthenticationController < ApplicationController

  skip_before_action :check_admin_session, only: [:authenticate_admin]


  def authenticate_admin
    admin = Admin.find_for_database_authentication(email: params[:email])
    if admin.present? and admin.valid_password?(params[:password])
      render json: payload(admin)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  def admin_logout
    reset_session
    cookies.delete("_session_id")
    render json: {
        destroyed: true
    }
  end

  private

  def payload(admin)
    return nil unless admin and admin.id
    response.set_header('Authorization', JsonWebToken.encode({admin_id: admin.id}))
    {
        auth_token: JsonWebToken.encode({admin_id: admin.id}),
        admin: {id: admin.id, email: admin.email}
    }
  end
end
