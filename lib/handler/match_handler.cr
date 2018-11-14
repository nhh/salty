require "configuration"

require "uri_scheme"

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
        return puts "[ERROR] no path mapping could be found for #{vhost.path}" if vhost.scheme == UriScheme::NONE
        self.next= HTTP::StaticFileHandler.new "." if vhost.scheme == UriScheme::FILE
    end
    
end