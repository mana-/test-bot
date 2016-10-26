
# slackbot用
require 'slack-ruby-client'

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
client = Slack::RealTime::Client.new

api = Slack::Web::Client.new

# slackに接続OKの場合のイベントハンドラ
client.on :hello do
  puts 'connected!'
  client.message channel: CHANNEL_ID, text: 'connected!'
end

# message通知
client.on :message do |data|
  puts 'message'
  puts data
  if data.text == 'blog' then
    
  end
  client.message channel: CHANNEL_ID, text: "Hi <@#{data.user}>!"
end

# クライアントセッション起動
client.start!

