require 'rest-client'
class GetCorrectedText
  URI = "https://api.cognitive.microsoft.com/bing/v5.0/spellcheck/"
  BING_SPELL_CHECK_KEY = ENV["BING_SPELL_CHECK_KEY"]
  def call(text, mode)
    correct_spelling_errors(text, response_from_api(text, mode))
  end

  private
  def response_from_api(text, mode)
    uri = "#{URI}?text=#{text}&mode=#{mode}"
    headers = {"Ocp-Apim-Subscription-Key" => BING_SPELL_CHECK_KEY}
    return_result = RestClient.get(uri, headers)
    JSON.parse(return_result).deep_symbolize_keys!
  end

  def correct_spelling_errors(text, suggestions)
    text_tokens = text.split(" ")
    if  suggestions.instance_of?(Hash) && suggestions[:flaggedTokens].present? 
      suggestions[:flaggedTokens].each do |token|
        text_tokens[text_tokens.index(token[:token])] = token[:suggestions].first[:suggestion]
      end
    end
    text_tokens.join(" ")
  end
end