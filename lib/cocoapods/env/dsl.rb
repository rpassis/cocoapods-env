module Pod
    class Podfile
        module DSL
            class << self
                user_defined_options = []
                attr_accessor :user_defined_options
            end

            def user_defined_options
                DSL.user_defined_options
        end
        end
    end
end
