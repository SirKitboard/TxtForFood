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
  account_sid = 'AC4d165f7a1f552d6265f691a7bcfb0204'
  auth_token = '16294e680544dd2c8e232a551d582aab'
  @client = Twilio::REST::Client.new account_sid, auth_token
 
 
  #name = friends[sender] || "Mobile Monkey"
  twiml = Twilio::TwiML::Response.new do |r|
    request = Location.new(
             :term => @client.account.sms.messages.list.first.body.to_s[6..@client.account.sms.messages.list.first.body.to_s.length],
             :address => @client.account.sms.messages.list.first.body[0..5].to_s,
             :limit => 1)
    response = client.search(request)
    retards =  response.to_s.split('"')
    for i in 0..retards.length
      if retards[i]=="name"
        r.Message retards[i+2]
      end
    end
    #r.Message @client.account.sms.messages.list.first.body
  end
  twiml.text
end