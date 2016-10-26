
require 'slack-ruby-client'

# 各設定情報

# botのTOKENをセット
TOKEN = ENV['SLACK_TOKEN_ID']
# チャットID(privateチャットはgroups.listで取得可能)
CHANNEL_ID = ENV['SLACK_CHANNEL_ID_ABU']

Slack.configure do |config|
  config.token = TOKEN 
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::INFO
  fail 'Missing token!' unless config.token
end

# RTM Clientのインスタンス生成
client = Slack::Web::Client.new

# つぶやく
client.chat_postMessage(channel: CHANNEL_ID, text: 'hello')

