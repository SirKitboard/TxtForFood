require 'rubygems'
require 'twilio-ruby'
require 'yelpster'
require 'sinatra'
require 'yelpster'
require 'json'
client = Yelp::Client.new
  include Yelp::V2::Search::Request
  Yelp.configure(:yws_id          => 'jIW1niVeaxfQ-GDKDsjeeg',
               :consumer_key    => 'xoBfuWAfta2vogYhMsgNkg',
               :consumer_secret => 'SzqKgJTN9VMrxmaBuzprD_psdPI',
               :token           => 'EaX1frcRQknqAOviejeu1dRgBZIha1cp',
               :token_secret    => 'hTPpgXt0ELV21x-gmEkSWLtv0r8')
get '/sms-quickstart' do  
  sender = params[:From]
  account_sid = 'AC4d165f7a1f552d6265f691a7bcfb0204'
  auth_token = '16294e680544dd2c8e232a551d582aab'
  @client2 = Twilio::REST::Client.new account_sid, auth_token
  friends = {
    "+14153334444" => "Curious George",
    "+14158157775" => "Boots",
    "+14155551234" => "Virgil"
  }
  name = friends[sender] || "Mobile Monkey"
  twiml = Twilio::TwiML::Response.new do |r|
    request = Location.new(
             :term => @client2.account.sms.messages.list.first.body[6..@client2.account.sms.messages.list.first.body.length],
             :address => @client2.account.sms.messages.list.first.body[0..4],
             :limit => 1)
    response = client.search(request)
    results =  response.to_s.split('"')
    name = ""
    address = ""
    city = ""
    postal_code = ""
    state_code = ""
    for i in 0..results.length
      if results[i]=="name"
        name = results[i+2]
      end
      if results[i]=="address"
        address = results[i+2]
      end
      if results[i]=="city"
        city = results[i+2]
      end
      if results[i]=="postal_code"
        postal_code = results[i+2]
      end
      if results[i+1]=="state_code"
        state_code = results[i+3]
      end    
    end
    r.Message "We recommend : "+name+", Located At "+address+", "+city+", "+state_code+"-"+postal_code
  end
  twiml.text
end