require "yaml"

module Walter
  class Configuration

    getter host : String
    getter port : UInt16
    getter vhosts = [] of VirtualHost

    def initialize(host : String, port : UInt16, vhosts : Array(VirtualHost))
      @host = host
      @port = port
      @vhosts = vhosts
    end

    def self.load_configurations : Array(Configuration)
      Dir.glob("./config/*.yml").map do |file_path|
        conf = YAML.parse(File.read(file_path))
        #pp conf["virtual-hosts"].as_h
        vhosts = [VirtualHost.new("https://tools.ietf.org/html/rfc8089", "/")]
        Configuration.new(conf["host"].as_s, conf["port"].as_i.to_u16, vhosts)
      end
    end
    
  end
end
