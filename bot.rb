require 'bundler/setup'
require 'redd'

@r = Redd.it(:script, "8uh-Qlc8JykRIg", "8WBQAnV_jmwt2zqheetMWHVoTMo", "bot_test_69", "vegeta88", user_agent: "TestBot v1.0.0")
@r.authorize!

def stream(word)
  @r.stream :get_comments, "barelyknewye" do |comment|
    comment.reply("#{word}? I barely know her!") if comment.body.include? word
  end
end

begin
  stream("liquor")
rescue Redd::Error::RateLimited => error
  sleep(error.time)
  retry
rescue Redd::Error => error
  # 5-something errors are usually errors on reddit's end.
  raise error unless (500...600).include?(error.code)
  retry
end
