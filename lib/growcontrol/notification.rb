module GrowControl

  class Notification

    EMAIL_RECEIVER_ADDRESS = "per.kristian.nordnes@gmail.com"
    EMAIL_SENDER_ADDRESS = "Raspberry Pi <per.kristian.nordnes@gmail.com>"
    SENDMAIL_LOCATION = {:location => (`which sendmail`.chomp)}

    def self.warn_about_temperature(temperature)
      Mail.deliver do
        delivery_method :sendmail, SENDMAIL_LOCATION
        to      EMAIL_RECEIVER_ADDRESS
        from    EMAIL_SENDER_ADDRESS 
        subject "[GrowControl Watcher] Temperature warning"
        body    "Temperature is now #{temperature} degrees!"
      end
    end

    def self.warn_about_humidity(humidity)
      Mail.deliver do
        delivery_method :sendmail, SENDMAIL_LOCATION
        to      EMAIL_RECEIVER_ADDRESS
        from    EMAIL_SENDER_ADDRESS 
        subject "[GrowControl Watcher] Humidity warning"
        body    "Humidity is now #{humidity}%!"
      end
    end

    def self.warn_about_exception(e)
      Mail.deliver do
        delivery_method :sendmail, SENDMAIL_LOCATION
        to      EMAIL_RECEIVER_ADDRESS
        from    EMAIL_SENDER_ADDRESS
        subject "[GrowControl Watcher] #{e.message}"
        body    "%s\n  %s" % [e.message, e.backtrace.join("\n  ")]
      end   
    end

  end

end