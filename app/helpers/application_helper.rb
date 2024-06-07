# app/helpers/application_helper.rb

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      flash_type.to_s
    end
  end

  def flash_messages(_opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade show", data: {controller: "flash"}) do
        concat(content_tag(:button, '', class: "btn-close", data: { bs_dismiss: 'alert' }))
        concat message
      end)
    end
    nil
  end
end
