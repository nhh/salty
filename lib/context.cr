require "configuration"

class Context < HTTP::Server::Context

    def initialize(configuration : Configuration)
        super
        @configuration = configuration
    end

end