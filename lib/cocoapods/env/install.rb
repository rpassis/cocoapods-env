module Pod
    class Command
        class Install

            alias_method :original_initialize, :initialize

            def initialize(argv)
                options = remove_from_argv(argv, 'user-defined-')
                update_podfile(options)
                original_initialize(argv)
            end

            private

            def remove_from_argv(argv, key)
                options = filter_by_key(argv.options, key)
                options.keys.each { |k| argv.option("#{key}#{k}") }
                options
            end

            def filter_by_key(options, key)
                filtered_options = {}
                options.each do |(k, v)|
                    if v == 'true' then v = true
                    elsif v == 'false' then v = false
                    end
                    filtered_options[k.gsub(key, '').to_sym] = v if k.include?(key)
                end
                filtered_options
            end

            def update_podfile(options)
                Pod::Podfile::DSL.user_defined_options = options
            end

            class << self
                alias_method :original_options, :options

                def options
                    new_option = [['--user-defined-{key}=value', 'Adds user defined flags that can be accessed inside the Podfile']]
                    original_options.concat(new_option)
                end
            end
        end
    end
end
