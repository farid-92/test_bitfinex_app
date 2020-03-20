class Service < ApplicationRecord

  default_scope {order(created_at: :desc)}

  validates :url, presence: true
  validates :name, presence: true

  enum service_type: [:tickers, :ticker, :candle]

end
