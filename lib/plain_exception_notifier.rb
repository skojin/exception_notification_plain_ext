ExceptionNotifier.module_eval do
# notify about not controller exception, like in cron tasks
  def plain_exception_notification(exception, location_name = nil)
    subject    "#{email_prefix}#{location_name ? '': ''}#{location_name} (#{exception.class}) #{exception.message.inspect}"

    recipients exception_recipients
    from       sender_address

    backtrace = sanitize_backtrace(exception.backtrace)
    body <<EOF
A #{exception.class} occurred in #{location_name}:

  #{exception.message}
  #{backtrace.first}

#{backtrace.join "\n"}
EOF
  end
end