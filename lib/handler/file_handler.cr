require "virtual_host"

class FileHandler < HTTP::StaticFileHandler

    def initialize(vhost : VirtualHost)
        super directory(vhost.target)
    end

    private def directory(uri : URI) : String
        return File.dirname(uri.path.to_s)
    end

end