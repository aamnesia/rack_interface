require_relative 'time_formatter'

class App

  def call(env)
    request = Rack::Request.new(env)
    create_response(request)
  end

  private

  def create_response(request)
    return response(404, "Not found") if request.path_info != '/time'

    time_formatter = TimeFormatter.new(request.params)
    time_formatter.call

    if time_formatter.success?
      response(200, time_formatter.time_string)
    else
      response(400, time_formatter.invalid_string)
    end
  end

  def response(status, body)
    resp = Rack::Response.new
    resp.status = status
    resp.header['Content-Type'] = 'text/plain'
    resp.write(body.to_s)
    resp.finish
  end

end
