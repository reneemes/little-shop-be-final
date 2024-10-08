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
      message: "Creation failed",
      errors: messages
    }
  end

  def self.active_status_error
    { 
      message: "Cannot deactivate coupon while applied to an invoice", 
      errors: ["cannot process request"] 
    }
  end
end