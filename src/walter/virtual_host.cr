module Walter

    enum Scheme
        HTTP,
        HTTPS,
        FILE
    end

    class VirtualHost
        YAML.mapping(
            target: String,
            path: String,
            dynamic: Bool,
            port: UInt16
        )
        getter target : String
        getter path : String
        getter dynamic = false
        getter port : UInt16

        def initialize(target : String, path : String, port : UInt16)
            @target = target
            @path = path
            @port = port
        end

        def scheme : Scheme
            return HTTP if @target.starts_with?("http://")
            return HTTPS if @target.starts_with?("https://")
            return FILE if @target.starts_with?("file://")
        end

    end

end