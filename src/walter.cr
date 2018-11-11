require "./walter/*"

module Walter
  VERSION = "0.1.0"
  HANDLERS = [] of Server
  
  puts File.read("./src/banner.txt")

  configs = Configuration.load_configurations

  configs.each do |config|
    server = Server.new(config)
    server.run
    HANDLERS << server
  end

  Fiber.yield
  sleep

end
