class ErrorSerializer
  def self.format_errors(messages)
    {
      message: 'Your query could not be completed',
      errors: messages
    }
  end

  def self.format_invalid_search_response
    { 
      message: "your query could not be completed", 
      errors: ["invalid search params"] 
    }
  end

  def self.creation_error(messages)
    {
      message: messages,
      errors: ["param is missing or the value is empty: coupon"]
    }
  end
end