require "http/server"
require "json"
require "uri"
require "benchmark"

require "configuration"
require "handler/match_handler"

class Server
  @configuration : Configuration
  @is_running = false

  def initialize(configuration : Configuration)
    @configuration = configuration
  end

  def run
    return if @is_running

    spawn do
      server = HTTP::Server.new([
        HTTP::ErrorHandler.new,
        HTTP::LogHandler.new,
        HTTP::CompressHandler.new,
        MatchHandler.new @configuration,
      ])
      address = server.bind_tcp "127.0.0.1", @configuration.port.to_i
      puts "Server is listening on #{address}"
      server.listen
    end
    @is_running = true
  end

  private def prepared_request(ctx : HTTP::Server::Context) : HTTP::Request
    HTTP::Request.new(
      ctx.request.method,
      ctx.request.resource,
      ctx.request.headers,
      ctx.request.body
    )
  end



end
