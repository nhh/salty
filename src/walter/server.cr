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
          context.response.content_type = "text/plain"
          context.response.print "Hello world! The time is #{Time.now}"
        end
        
        address = server.bind_tcp @configuration.port.to_i
        puts "Listening on http://#{address}"
        server.listen
      end

      @is_running = true
    end

  end
end
