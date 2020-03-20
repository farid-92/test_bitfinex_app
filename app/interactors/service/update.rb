class Service::Update
  include Interactor

  def call
    params = context.params
    service = context.service
    if service.update(params)
      context.service = service
      context.status = :accepted
    else
      context.status = :unprocessable_entity
      context.fail! errors: service.errors
    end
  end
end
