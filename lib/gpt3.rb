require_relative "bot_text_few_shots_learning"

class Bot
  ENGINE = "davinci" # text generation / compleition / conversation

  attr_reader :bot_config

  def initialize(bot_config)
    @bot_config = bot_config
  end

  def prompt(message:)
    bot_text = BOT_TEXT_1
    # bot_text = BOT_TEXT_1
    message.strip!
    msg_init = ""
    # TODO!
    # msg_init = base_msg
    msg = "
    #{msg_init}
    #{bot_text}

    Human: #{message}
    Bot1:" # TODO: remove any trailing spaces
    msg = format_msg msg: msg
    answer = openai_complete_text text: msg
    msg = "Bot1: #{answer}"
    msg
  end

  private

  def base_msg
    # TODO: load from bot_config
    bot_config
    bot_config.f :personality
  end

  def openai_complete_text(text:)
    bot_api = OpenAI::Client.new access_token: OPENAI_TOKEN
    puts "TEXT"
    puts text
    puts "---------"
    response = bot_api.completions(
      engine: "davinci",
      parameters: {
        prompt: text,
        max_tokens: 40,
        stop: ["Human:"],
      },
    )
    resp = response.f "choices"
    resp = resp.f 0
    resp = resp.f "text"
    puts "resp: #{resp}"
    resp
  end

  def format_msg(msg:)
    lines = msg.split "\n"
    strip_lines lines: lines
  end

  def strip_lines(lines:)
    lines.map do |line|
      line.strip
    end.join "\n"
  end

end

GPT3Demo = -> (prompt, bot_id:) {
  bot_config = BOTS.f :bot1
  user_prompt = prompt.strip
  bot = Bot.new bot_config: bot_config
  response = bot.prompt message: user_prompt
  # prompt += "\n#{user_prompt}"
  p response
  response
}

if __FILE__ == $0
  raise "asd"
end
