module GcmUtils

  def self.send_android_push_notifications(registration_ids, options)
    gcm = GCM.new("AIzaSyCxdOMoJCp0yM2GTuKTz36oBufRqXzgMAw")
    options = {data: options}
    response = gcm.send_notification(registration_ids, options)
  end
end
