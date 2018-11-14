require "configuration"
require "handler/file_handler"

class MatchHandler

    include HTTP::Handler
    
    def initialize(configuration : Configuration)
        @configuration = configuration
    end

    def call(context)
        match_path(context.request.path)
        call_next(context)
    end

    private def match_path(path : String)
        vhost = @configuration.vhosts.find { |vhost| vhost.path == path }
        return puts "[ERROR] no virtual hosts configured" unless vhost
        self.next= FileHandler.new vhost if vhost.target.scheme == "file"
    end

end