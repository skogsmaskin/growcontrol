module GrowControl

  class Notification

    SENDMAIL_LOCATION = {:location => (`which sendmail`.chomp)}

    def self.warn_about_temperature(temperature)
      Mail.deliver do
        delivery_method :sendmail, SENDMAIL_LOCATION
        to      $config[:email_receiver_address]
        from    $config[:email_sender_address]
        subject "[GrowControl] Temperature warning"
        body    "Temperature is now #{temperature} degrees!"
      end
    end

    def self.warn_about_humidity(humidity)
      Mail.deliver do
        delivery_method :sendmail, SENDMAIL_LOCATION
        to      $config[:email_receiver_address]
        from    $config[:email_sender_address]
        subject "[GrowControl] Humidity warning"
        body    "Humidity is now #{humidity}%!"
      end
    end

    def self.warn_about_exception(e)
      Mail.deliver do
        delivery_method :sendmail, SENDMAIL_LOCATION
        to      $config[:email_receiver_address]
        from    $config[:email_sender_address]
        subject "[GrowControl] #{e.message}"
        body    "%s\n  %s" % [e.message, e.backtrace.join("\n  ")]
      end   
    end

  end

end