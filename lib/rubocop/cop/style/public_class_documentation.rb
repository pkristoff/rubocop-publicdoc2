# frozen_string_literal: true

module RuboCop
  module Cop
    module Style
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @example EnforcedStyle: PublicClassDocumentation (default)
      #   # Description of the `PublicClassDocumentation` style.
      #
      #   # bad
      #   class xxx
      #
      #   # bad
      #   # class xxx documentation
      #   class xxx
      #
      #   # bad
      #   # class xxx documentation
      #   # the end
      #   class xxx
      #
      #   # good
      #   # class xxx documentation
      #   #
      #   class xxx
      #
      class PublicClassDocumentation < Documentation
        # TODO: Implement the cop in here.
        #
        # In many cases, you can use a node matcher for matching node pattern.
        # See https://github.com/rubocop/rubocop-ast/blob/master/lib/rubocop/ast/node_pattern.rb
        #
        # For example

        # overide method to add on my class doc
        #
        # === Parameters:
        #
        # * <tt>:node</tt> a class node
        #
        def on_class(node)
          check_class_comment(node, :class)
          super
        end

        private

        def check_class_comment(node, type)
          if documentation_comment?(node)
            add_offense(preceding_lines(node).last, message: 'Class documentation should end with an empty line') unless class_comment_blank?(node)
          else
            add_offense(node, message: 'Missing class documentation')
          end
        end

        def class_comment_blank?(node)
          # assumes a comment exists
          last_line = preceding_lines(node).last
          /^\#$/.match?(last_line.text)
        end
      end
    end
  end
end
