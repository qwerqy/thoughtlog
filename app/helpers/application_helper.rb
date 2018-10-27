module ApplicationHelper
  def flash_class(level)
    case level
    when :success then return "ui positive message"
    when :error then return "ui error message"
    when :notice then return "ui notice message"
    end
  end
end
