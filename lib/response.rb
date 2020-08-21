class Response
  attr_reader :code
  
  def initialize(code:, data: "")
    @code = code
    @response =
      "HTTP/1.1 #{code}\r\n" +
      "Content-Length: #{data.size}\r\n" +
      "\r\n" +
      "#{data}\r\n"
  end

  def send(client)
    client.write(@response)
  end
end
