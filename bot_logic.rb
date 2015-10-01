# -*- coding: utf-8 -*-
require 'sinatra/base'
require 'net/http'
require 'uri'
require 'json'

SLACK_DOMAIN = ENV['SLACK_DOMAIN']
SLACKBOT_ENDPOINT = ENV['SLACKBOT_ENDPOINT']
SLACKBOT_TOKEN = ENV['SLACKBOT_TOKEN']

class BotLogic < Sinatra::Base
  get('/') do
    puts "Processing get / request"
    "I'm up."
  end

  post('/lenny') do
    puts "Processing /lenny command"
    # post response to $SLACK_DOMAIN$SLACKBOT_ENDPOINT$SLACKBOT_TOKEN
    response_text = "( ͡° ͜ʖ ͡°)"
    puts params
    channel = params[:channel_id]
    begin
      uri = URI.parse("#{SLACK_DOMAIN}#{SLACKBOT_ENDPOINT}?token=#{SLACKBOT_TOKEN}&channel=#{channel}")
#      params = {
#        token: SLACKBOT_TOKEN,
#        channel: channel,
#        body: response_text
#      }
#      puts "Posting #{params.inspect} to url #{uri}"
      request = Net::HTTP.Post.new(url.path)
      http = Net::HTTP.new(url.host, url.port)
      request.body = response_text
      response = http.request(request)
      puts response
      puts response.body
    rescue Exception => e
      logger.info "Got exception #{e}"
      puts "WTF!"
      raise e
    end
  end

  run! if app_file == $0
end
