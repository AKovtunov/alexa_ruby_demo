class ResponseSetter
  def self.default_schema_for_response(text, end_session=false)
    {
      "version": "1.0",
      "response": {
        "outputSpeech": {
          "type": "PlainText",
          "text": text,
        },
        "shouldEndSession": end_session
      }
    }
  end
end
