require 'rubygems'
require 'twilio-ruby'
class SMS

  def send_sms(order_id, name, cost, order)

    account_sid = 'removed from github'
    auth_token = 'removed from github'

    client = Twilio::REST::Client.new account_sid, auth_token

      client.messages.create(
        from: '+removed from github',
        to: '+removed from github',
        body: "Hi #{name}, Thanks for you order #{order_id} of #{order} totalling £#{cost}. Your food will be delivered in 1hr!"
      )
  end
end
