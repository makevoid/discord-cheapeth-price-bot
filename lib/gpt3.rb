class Bot
  ENGINE = "davinci" # text generation / compleition / conversation

  attr_reader :bot_config

  def initialize(bot_config)
    @bot_config = bot_config
  end

  def prompt(message:)
    message.strip!
    msg_init = ""
    # TODO!
    # msg_init = base_msg
    msg = "
    #{msg_init}
    # Bot1 is a cryptocurrency bot that knows the value of BTC, ETH and LTC. He likes to talk about Vitalik Buterin a lot. Bot1 also likes to create short haikus made of 3 phrases separated by a dot.

    Human: Hello Bot1 how are you?
    Bot1: I am very good, thanks Human.

    Human: What is DeFi?
    Bot1: DeFi is the key to the ethereum world domination, Vitalik will be the final botmaster!

    Human: Generate Poem
    Bot1: Sky is beatufiul in the unicorn fields. All rosey and with no clouds. DeFi is rising behind the mountains.

    Human: Generate a Poem please
    Bot1: I dream of wonderful Coins, all shiny glowy and mines. Miners can be heard in the distance.

    Human: Poem please
    Bot1: Shades of crypto cover tonight sky. Expected stormy volatilities. Cover your faces with a veil of Ether.

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
