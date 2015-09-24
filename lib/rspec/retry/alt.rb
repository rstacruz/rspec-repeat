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
        example = RSpec.current_example
        wait = options[:wait]
        exceptions = options[:exceptions]
        verbose = options[:verbose]
        verbose = !!ENV['RSPEC_RETRY_VERBOSE'] if verbose.nil?
        clear_lets = options[:clear_lets]
        clear_lets = true if clear_lets.nil?

        count.times do |i|
          example.instance_variable_set :@exception, nil
          ex.run
          break if example.exception.nil?
          break if 
          Utils.print_failure(i, example) if verbose
          self.clear_lets if clear_lets
          sleep wait if wait.to_i > 0
        end
      end

      def clear_lets
        if respond_to? :__init_memoized, true
          __init_memoized
        else
          @__memoized = nil
        end
      end

      module Utils # :nodoc:
        module_function

        def print_failure(i, example)
          msg =
            "RSpecRetryAlt: #{nth(i + 1)} try error in #{example.location}:\n" \
            "  #{example.exception}\n"
            puts msg
        end

        def nth(n)
          if n % 10 == 1 && n != 11
            "#{n}st"
          elsif n % 10 == 2 && n != 11
            "#{n}nd"
          elsif n % 10 == 3 && n != 11
            "#{n}rd"
          else
            "#{n}th"
          end
        end

        def matches_exceptions?(exceptions, exception)
          return unless exceptions
          exceptions.any? do |exception_klass|
            exception.is_a?(exception_klass)
          end
        end
      end
    end
  end
end
