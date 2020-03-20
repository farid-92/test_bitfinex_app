class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :url, :service_type, :name
end
