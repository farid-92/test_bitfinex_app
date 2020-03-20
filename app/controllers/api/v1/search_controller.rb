class Api::V1::SearchController < ApplicationController

  skip_before_action :check_admin_session, only: [:get_ticker]

  def get_ticker
    @symbol = params[:symbol]
    @ticker_services = Service.where(service_type: Service.service_types['ticker'])
    hash ={}
    @ticker_services.each do | ticker_service|
    host = ticker_service.url + @symbol
    uri = URI(host)
    res = Net::HTTP.get_response(uri)
    hash.merge!({"#{ticker_service.name}": JSON.parse(res.body) })
    end

    render json: hash


  end

end
