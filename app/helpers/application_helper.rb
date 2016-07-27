module ApplicationHelper

  def bootstrap_class_for flash_type
    case flash_type
    when :success
      "alert-success"
    when :error
      "alert-error"
    when :alert
      "alert-block"
    when :notice
      "alert-info"
    else
      flash_type.to_s
    end
  end

	def root_page_path
		user_signed_in? ? dashboard_path : root_path
  end

end
