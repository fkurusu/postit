module ApplicationHelper
  def fix_url(url_str)
    url_str.starts_with?('http://') ? url_str : "http://#{url_str}"
  end

  def display_datetime(date)
    "#{time_ago_in_words(date)} ago."
  end
end
