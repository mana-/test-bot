
# slackbot用
require 'slack-ruby-client'
# twitter用
require 'twitter'
require 'tweetstream'

# botのTOKENをセット
TOKEN = ENV['SLACK_TOKEN_ID']
# チャットID(privateチャットはgroups.listで取得可能)
CHANNEL_ID_ABU_ALL = ENV['SLACK_CHANNEL_ID_ABU']

TWITTER_TARGET_ID = ENV['TWITTER_TARGET_USER_ID']

# Slackの設定
Slack.configure do |config|
  config.token = TOKEN
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::INFO
  fail 'Missing token!' unless config.token
end

TweetStream.configure do |twitter_config|
  twitter_config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
  twitter_config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
  twitter_config.oauth_token        = ENV['TWITTER_CONSUMER_TOKEN']
  twitter_config.oauth_token_secret = ENV['TWITTER_CONSUMER_TOKEN_SECRET']
  twitter_config.auth_method        = :oauth
end

slack_client = Slack::Web::Client

# 特定ユーザーのツイートをチェック
#TweetStream::Client.new.follow('2792042310', '1195665890') do |status|
TweetStream::Client.new.follow('2792042310') do |status|
  user_client = status.source.gsub(/(<a href=".*" rel=".*">)(.*)(<\/a>)/, '\2')
  puts "#{status.user.name}: #{status.text}"
  puts status.uri
  puts "  app:#{user_client}"
  puts "-----"
  puts status.user.class

#  post_message = "--------\n #{status.user.name}\n #{status.text}\n app:#{user_client}"
#  if status.user.id == TWITTER_TARGET_ID
#    slack_client.chat_postMessage(channel: CHANNEL_ID_ABU_ALL, text: post_message)
#    slack_client.chat_postMessage(channel: CHANNEL_ID_ABU_ALL, text: post_message)
#  else

#  end
end
