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
  end

  def call
    @params.each do |format|
      if TIME_FORMATS[format]
        @available_formats << TIME_FORMATS[format]
      else
        @unknown_formats << format
      end
    end
  end

  def success?
    @unknown_formats.empty?
  end

  def invalid_string
    "Unknown time format #{@unknown_formats}"
  end

  def time_string
    Time.now.strftime(@available_formats.join('-'))
  end

end
