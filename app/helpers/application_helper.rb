module ApplicationHelper
  def pretty_date(date)
		return date.strftime("%B %-d, %Y")
	end
end
