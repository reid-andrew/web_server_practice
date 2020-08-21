require 'socket'
require './lib/request_parser'
require './lib/response_preparer'

server = TCPServer.new('localhost', 8080)

loop{
  client = server.accept
  request = client.readpartial(2048)

  request = RequestParser.parse(request)
  response = ResponsePreparer.prepare(request)

  puts "#{client.peeraddr[3]} #{request.fetch(:path)} - #{response.code}"

  response.send(client)
  client.close
}
