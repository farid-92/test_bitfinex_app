class Service::Create
  include Interactor

  def call
    params = context.params
    service = Service.create(params)
    if service.valid?
      context.service = service
      context.status = :created

    else
      context.status = :unprocessable_entity
      context.fail! errors: service.errors
    end
  end
end
