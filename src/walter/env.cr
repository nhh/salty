require "./configuration"

module Walter
    class Env
        def self.load_configurations : Array(Walter::Configuration)
            [Configuration.new("0.0.0.0", 1919), Configuration.new("0.0.0.0", 2020)]
        end
    end
end