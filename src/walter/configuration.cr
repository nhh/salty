module Walter
  class Configuration
    @host : String
    @port : UInt16

    def initialize(host : String, port : UInt16)
      @host = host
      @port = port
    end

    def port
      @port
    end
    
  end
end
