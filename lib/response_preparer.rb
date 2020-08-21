require './lib/response'

class ResponsePreparer
  class << self
    SERVER_ROOT = "./tmp/web-server"

    def prepare(request)
      if request.fetch(:path) == "/"
        respond_with(SERVER_ROOT + "/index.html")
      else
        respond_with(SERVER_ROOT + "/#{request.fetch(:path)}.html")
      end
    end

    private

    def respond_with(path)
      if File.exists?(path)
        send_ok_response(File.binread(path))
      else
        send_file_not_found
      end
    end

    def send_ok_response(data)
      Response.new(code: 200, data: data)
    end

    def send_file_not_found
      Response.new(code: 404)
    end
  end
end
