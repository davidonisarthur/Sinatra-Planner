class ApplicationController
  attr_accessor :params, :options

  SUCCESS = [ 200, 204 ]

  def  initialize(*args, **options)
    @params = args[0]
    @options = options
  end

  def build_response(message, status)
    return { data: message.to_json, status: status } if SUCCESS.include?(status)

    { data: { errors: { message: [ message ] } }.to_json, status: status }
  end
end
