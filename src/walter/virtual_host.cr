module Walter

    enum Scheme
        HTTP,
        HTTPS,
        FILE
    end

    class VirtualHost
        getter target : String
        getter path : String

        def initialize(target : String, path : String)
            @target = target
            @path = path
        end

        def scheme
            return HTTP if @target.starts_with?("http://")
            return HTTPS if @target.starts_with?("https://")
            return FILE if @target.starts_with?("file://")
        end

    end

end