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
            dynamic: Bool
        )
        getter target : String
        getter path : String
        getter dynamic = false

        def initialize(target : String, path : String)
            @target = target
            @path = path
        end

        def scheme : Scheme
            return HTTP if @target.starts_with?("http://")
            return HTTPS if @target.starts_with?("https://")
            return FILE if @target.starts_with?("file://")
        end

    end

end