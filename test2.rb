require 'rubygems'
require 'twilio-ruby'
require 'yelpster'
require 'sinatra'
require 'yelpster'
require 'json'
get '/sms-quickstart' do
  client = Yelp::Client.new
  include Yelp::V2::Search::Request
  Yelp.configure(:yws_id          => 'jIW1niVeaxfQ-GDKDsjeeg',
               :consumer_key    => 'xoBfuWAfta2vogYhMsgNkg',
               :consumer_secret => 'SzqKgJTN9VMrxmaBuzprD_psdPI',
               :token           => 'EaX1frcRQknqAOviejeu1dRgBZIha1cp',
               :token_secret    => 'hTPpgXt0ELV21x-gmEkSWLtv0r8')

  sender = params[:From]
  friends = {
    "+14153334444" => "Curious George",
    "+14158157775" => "Boots",
    "+14155551234" => "Virgil"
  }
  name = friends[sender] || "Mobile Monkey"
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message "Hello, #{name}. Thanks for the message."
  end
  twiml.text
end