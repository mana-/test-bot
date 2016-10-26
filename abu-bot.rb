
# slackbot用
require 'slack-ruby-client'
# twitter用
require 'twitter'

# botのTOKENをセット
TOKEN = ENV['SLACK_TOKEN_ID']
# チャットID(privateチャットはgroups.listで取得可能)
CHANNEL_ID = ENV['SLACK_CHANNEL_ID_ABU']

# Slackの設定
Slack.configure do |config|
  config.token = TOKEN
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::INFO
  fail 'Missing token!' unless config.token
end

# Twitter設定
client_stream = Twitter::Streaming::Client.new do |twitter_config|
  twitter_config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
  twitter_config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  twitter_config.access_token        = ENV['TWITTER_CONSUMER_TOKEN']
  twitter_config.access_token_secret = ENV['TWITTER_CONSUMER_TOKEN_SECRET']
end

api = Slack::Web::Client.new

client_stream.user do |object|
#  if object.is_a?(Twitter::Tweet)
#    puts "screen name:" + object.user.screen_name
#    puts "name:" + object.user.name
#    puts "test:" + object.text
#    puts "source:" + object.source.gsub(/(<a href=".*" rel=".*">)(.*)(<\/a>)/, '\2')
#  end
end

