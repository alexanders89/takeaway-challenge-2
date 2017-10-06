require 'rubygems'
require 'twilio-ruby'
class SMS

  account_sid = 'AC85d63b6b199aa2e579f511eaa1f74c44'
  auth_token = '643f6a8a91ec054bb6bc1e8fdca02ac4'

  client = Twilio::REST::Client.new account_sid, auth_token

    client.messages.create(
      from: '+441785472415',
      to: '+447791415382',
      body: "Hi! Thanks for ordering. Your food will be delivered in 1hr!"
    )
end
