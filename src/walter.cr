require "./walter/*"

module Walter
  VERSION = "0.1.0"
  HANDLERS = [] of Server

  configs = Env.load_configurations

  configs.each do |config|
    server = Server.new(config)
    server.run
    HANDLERS << server
  end

  Fiber.yield
  sleep
end
