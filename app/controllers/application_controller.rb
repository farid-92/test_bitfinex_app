class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :check_admin_session

  protected

  def authenticate_request!
    unless admin_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_admin = Admin.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private
  def check_admin_session
    admin_id = admin_id_in_token?
    unless admin_id.present?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    else
      @current_admin = Admin.find(admin_id)
    end
  end

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def admin_id_in_token?
    http_token && auth_token && auth_token[:admin_id].to_i
  end

end
