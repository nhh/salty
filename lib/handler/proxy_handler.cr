class ProxyHandler

    def initialize
        @configuration.vhosts[0].target
    end

    def call(context)
        client = HTTP::Client.new @configuration.vhosts[0].target, @configuration.vhosts[0].port
        client.exec(prepared_request(context)) { |response| prepared_response(context, response) }
    rescue exception
        prepare_bad_response(context)
    end

    private def prepared_response(ctx : HTTP::Server::Context, res : HTTP::Client::Response)
        ctx.response.status_code = res.status_code
        ctx.response.headers.merge!(res.headers)
        ctx.response.content_type = res.content_type.to_s
        ctx.response.print ""
    end
    
    private def prepare_bad_response(ctx : HTTP::Server::Context)
        ctx.response.status_code = 504
        ctx.response.content_type = "text/html"
        ctx.response.print "Bad Gateway"
    end

end
