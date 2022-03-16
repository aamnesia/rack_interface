require_relative 'time_formatter'

class App

  def call(env)
    @request = Rack::Request.new(env)
    create_response
    [status, headers, body]
  end

  private

  def create_response
    return path_not_found if @request.path_info != '/time'

    @time_formatter = TimeFormatter.new(@request.params)
    return invalid_format if !@time_formatter.valid?

    successfully_formatted
  end

  def status
    @status
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    [ @body ]
  end

  def successfully_formatted
    @status = 200
    @body = "#{@time_formatter.formatted_time}"
  end

  def path_not_found
    @status = 404
    @body = "Path not found"
  end

  def invalid_format
    @status = 400
    @body = "Unknown time format [#{@time_formatter.invalid_formats.join(", ")}]"
  end

end
