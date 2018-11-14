class VirtualHost
    YAML.mapping(
        target: String,
        path: String,
        dynamic: Bool,
    )

    getter path : String
    getter dynamic = false

    def initialize(target : String, path : String)
        @target = target
        @path = path
    end

    def target
        URI.parse @target
    end


end