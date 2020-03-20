class Api::V1::SearchController < ApplicationController

  skip_before_action :check_admin_session, only: [:get_ticker, :get_tickers, :get_candles]

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

  def get_candles
    time_frame = params[:TimeFrame]
    type = 'candle'
    symbol = params[:Symbol]
    section = params[:Section]
    queryParams = "/trade:#{time_frame}:#{symbol}/#{section}"
    results = get_data_from_services(type, queryParams, section)

    render json: results
  end

  private

  def get_data_from_services(type, query, section = '')
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
