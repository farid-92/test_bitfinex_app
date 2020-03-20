class Api::V1::ServicesController < ApplicationController

  skip_before_action :check_admin_session, only: :index
  before_action :fetch_service, only: [:update, :destroy]

  def index
    @services = Service.all
    render json: @services
  end

  def create
    @result = Service::Create.call(params: services_params)
    return render json:  ErrorsSerializer.serialize(@result.errors),  status: @result.status if @result.errors.present?

    render json: @result.service, serializer: ServiceSerializer, status: @result.status

  end

  def update
    @result = Service::Update.call(params: services_params, service: @service)
    return render json: ErrorsSerializer.serialize(@result.errors), status: @result.status  if @result.errors.present?
    render json: @result.service, serializer: ServiceSerializer, status: @result.status

  end

  def service_types
    render json: Service.service_types
  end

  def destroy
    @service.destroy
    render json: { message: 'Service deleted'}, status: :ok
  end

  private

  def fetch_service
    @service = Service.find(services_params[:id])
  rescue => e
    render json: { message:  e}, status: :not_found
  end

  def services_params
    params.permit  :id, :url, :service_type
  end

end
