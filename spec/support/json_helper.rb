module JSONHelpers

  def response_json
    response_json = JSON.parse(response.body)
    if response_json.respond_to?(:with_indifferent_access)
      response_json.with_indifferent_access
    else
      response_json.map(&:with_indifferent_access)
    end

  end

  %w[get post put patch delete].each do |method|
    define_method(method) do |path, headers, parameters = {}|
      headers ||= {}
      super path, headers: headers.merge('HTTP_ACCEPT' => 'application/json'), params: parameters
    end
  end

end
