class Service < ApplicationRecord

  validates :url, presence: true

  enum service_type: [:ticker, :candle]

end
