module LogsHelper
  def format_duration(minutes)
    return "" if minutes.nil?

    hours = minutes / 60
    mins = minutes % 60

    if hours > 0
      "#{hours}時間#{mins}分"
    else
      "#{mins}分"
    end
  end
end
