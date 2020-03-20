class Service < ApplicationRecord

  default_scope {order(created_at: :desc)}

  validates :url, presence: true

  enum service_type: [:ticker, :candle]

end
