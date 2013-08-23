module Capistrano
  class Configuration
    class Servers
      class RoleFilter

        def initialize(required, available)
          @required, @available = required, available
        end

        def self.for(required, available)
          new(required, available).roles
        end

        def roles
          if @required.include?(:all)
            available
          else
            required.select { |name| available.include? name }
          end
        end

        private

        def available
          if role_filter
            role_filter.split(',').map(&:to_sym)
          else
            @available
          end
        end

        def role_filter
          ENV['ROLES']
        end

        def required
          Array(@required).flat_map(&:to_sym)
        end
      end
    end
  end
end
