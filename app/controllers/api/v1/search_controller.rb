class Api::V1::SearchController < ApplicationController

  skip_before_action :check_admin_session, only: [:get_ticker, :get_tickers]

  def get_ticker
    @symbol = params[:symbol]
    @type = 'ticker'
    @queryParams = @symbol
    results = get_data_from_services(@type, @queryParams)

    render json: results
  end

  def get_tickers
    @symbols = params[:symbols]
    @type = 'tickers'
    @queryParams = "?symbols=#{@symbols}"
    results = get_data_from_services(@type, @queryParams)

    render json: results
  end

  private

  def get_data_from_services(type, query)
    @ticker_services = Service.where(service_type: Service.service_types[type])
    hash ={}
    @ticker_services.each do | ticker_service|
      host = ticker_service.url + query
      uri = URI(host)
      res = Net::HTTP.get_response(uri)
      hash.merge!({"#{ticker_service.name}": JSON.parse(res.body) })
    end
    hash
  end

end
