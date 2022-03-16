class TimeFormatter

  TIME_FORMATS = { "year"   => "%Y",
                   "month"  => "%m",
                   "day"    => "%d",
                   "hour"   => "%Hh",
                   "minute" => "%Mm",
                   "second" => "%Ss" }.freeze

  attr_reader :invalid_formats

  def initialize(params)
    @params = params['format'].split(',')
    check_formats
  end

  def valid?
    @invalid_formats.empty?
  end

  def formatted_time
    formats = @valid_formats.map { |format| TIME_FORMATS[format]}
    Time.now.strftime(formats.join('-'))
  end

  private

  def check_formats
    @valid_formats, @invalid_formats = @params.partition { |format| TIME_FORMATS[format] }
  end

end
