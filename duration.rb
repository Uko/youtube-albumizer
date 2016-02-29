class Duration

  def self.hmsm(hr, min, sec, mil)
    self.new (((hr * 60) + min) * 60 + sec) * 1000 + mil
  end

  def self.minutes_seconds(minutes, seconds)
    self.new (minutes * 60 + seconds) * 1000
  end

  def self.seconds_milliseconds(seconds, milliseconds)
    self.new seconds * 1000 + milliseconds
  end

  def self.from_string(str)

    match = str.match(/\A(?:(\d+):)?(\d{1,2}):(\d{1,2})(?:.(\d+))?\z/)

    raise ArgumentError, 'Wrong string format. Should be like: HH:MM:SS.mmm' if match.nil?

    self.hmsm *(match.captures.collect { |el| el.nil? ? 0 : el.to_i })

  end

  def initialize (milliseconds = 0)
    @milliseconds = milliseconds
  end

  def raw_milliseconds
    @milliseconds
  end

  def to_i
    @milliseconds
  end

  def hours
    (@milliseconds / 1000 / 3600).floor
  end

  def minutes
    (@milliseconds / 1000 / 60).floor % 60
  end

  def seconds
    (@milliseconds / 1000).floor % 60
  end

  def milliseconds
    @milliseconds % 1000
  end

  def to_s
    "#{self.hours.to_s + ':' unless self.hours == 0}#{self.minutes}:#{self.seconds}#{'.' + self.milliseconds.to_s unless self.milliseconds == 0}"
  end

  def -(other_duration)
    Duration.new @milliseconds - other_duration.to_i
  end



end
