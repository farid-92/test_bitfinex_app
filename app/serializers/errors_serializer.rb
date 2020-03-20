class ErrorsSerializer < ActiveModel::Serializer
  def self.serialize(errors)
    return if errors.nil?

    new_hash = errors.to_hash(true).map do |k, v|
      v.map { |msg| {source: k, message: msg} }
    end.flatten

    { errors: new_hash }
  end
end
