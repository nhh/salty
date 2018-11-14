require "yaml"
require "virtual_host"

class Configuration
  YAML.mapping(
    host: String,
    port: UInt16,
    vhosts: Array(VirtualHost)
  )

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
      Configuration.from_yaml(File.read(file_path))
    end
  end
  
end

