class TimeFormatter

  TIME_FORMATS = { "year"   => "%Y",
                   "month"  => "%m",
                   "day"    => "%d",
                   "hour"   => "%Hh",
                   "minute" => "%Mm",
                   "second" => "%Ss" }.freeze

  attr_reader :unknown_formats, :formatted_time

  def initialize(params)
    @params = params['format'].split(',')
    @available_formats = []
    @unknown_formats = []
    @formatted_time
  end

  def call
    check_formats
    format_time
  end

  private

  def format_time
    return unless @unknown_formats.empty?
    @formatted_time = Time.now.strftime(@available_formats.join('-'))
  end

  def check_formats
    @params.each do |format|
      if TIME_FORMATS[format]
        @available_formats << TIME_FORMATS[format]
      else
        @unknown_formats << format
      end
    end
  end

end
