require "http/server"
require "json"
require "uri"

require "./configuration"

module Walter

  class Server
    @configuration : Configuration
    @is_running = false

    def initialize(configuration : Configuration)
      @configuration = configuration
    end

    def run
      return if @is_running

      spawn do
        server = HTTP::Server.new do |context|
          request = HTTP::Request.new(
            context.request.method, 
            context.request.resource, 
            context.request.headers, 
            context.request.body, 
            version = "HTTP/1.1"
          )
          puts "[INFO] Working on #{request} with #{context}"
          client = HTTP::Client.new @configuration.vhosts[0].target, @configuration.vhosts[0].port
          response = client.exec(request)
          client.close
          client = nil

          context.response.content_type = "text/html"
          context.response.print response.body
          context.response.close
          context.request
        end
        puts "Listening on http://0.0.0.0:#{@configuration.port.to_s}"
        server.listen(@configuration.port.to_i, true)
      end

      @is_running = true
    end

  end
end
