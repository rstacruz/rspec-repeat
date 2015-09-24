require 'rspec/retry/alt/version'

module RSpec
  module Retry
    # Retry
    module Alt
      # Retries an example.
      #
      #     include Rspec::Retry::Alt
      #
      #     around do |example|
      #      rerun example, 3
      #     end
      #
      def rerun(ex, count, options = {})
        wait = options[:wait]
        exceptions = options[:exceptions]
        clear_lets = options[:clear_lets]
        clear_lets = true if clear_lets.nil?

        count.times do |i|
          example.clear_exception
          example.run
          break if example.exception.nil?
          break if Utils.matches_exceptions?(exceptions, example.exception)
          Utils.print_failure(i, example) if i < count - 1
          self.clear_lets if clear_lets
          sleep wait if wait.to_i > 0
        end
      end

      module Utils # :nodoc:
        module_function

        def print_failure(i, example)
          msg =
            "RSpecRetryAlt: #{i + 1} try error in #{example.location}:\n" \
            "  #{example.exception}\n"
          RSpec.configuration.reporter.message(msg)
        end

        def matches_exceptions?(exceptions, exception)
          return unless exceptions.any?
          exceptions.any? do |exception_klass|
            exception.is_a?(exception_klass)
          end
        end
      end
    end
  end
end
