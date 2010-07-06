require "rubygems"
require "sinatra"
require "haml"

require "pusher"
require "pit"

configure do
  config = Pit.get("pusher", :require => {
                     "app_id" => "your app id",
                     "key"    => "your key",
                     "secret" => "your secret"
                   })
  Pusher.app_id = config["app_id"]
  Pusher.key    = config["key"]
  Pusher.secret = config["secret"]
end

get "/" do
  haml :index
end

post "/" do
  name = params[:name]
  text = params[:text]

  Pusher["chat"].trigger("message", { :name => name, :text => text })
end
