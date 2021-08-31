# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Style::PublicMethodDocumentation, :config do
  let(:config) { RuboCop::Config.new(RuboCop::Publicdoc2::CONFIG) }

  it 'Missing public method documentation' do
    expect_offense(<<~RUBY)
      # class doc
      #
      class Admin < ApplicationRecord
        def xxx
        ^^^^^^^ Missing public method documentation comment for `xxx`.
        end
      end
    RUBY
  end
  describe 'Bad comment format' do
    it 'Missing blank comment line' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          ^^^^^^^^^^^^^^^^^^^^^^^ Description should end with blank comment.
          def xxx
          end
        end
      RUBY
    end
    it 'Legal comment' do
      expect_no_offenses(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          def xxx
          end
        end
      RUBY
    end
  end
  describe 'Bad comment format arguments' do
    it 'Missing parm comment' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          ^^^^^^^^^^^^^^^^^^^^^^^ Parameter is missing for `xxx`.
          #
          def xxx(p1, p2)
          end
        end
      RUBY
    end
    it 'Missing parm comment' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          # === Parameters:
          ^^^^^^^^^^^^^^^^^ Parameter body is empty.
          #
          #
          def xxx(p1, p2)
                  ^^ Parameter size `0` does not match argument size `2`.
          end
        end
      RUBY
    end
    it 'Wrong parm name comment' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          # === Parameters:
          #
          # * <tt>:options</tt>
          ^^^^^^^^^^^^^^^^^^^^^ Parameter name `options` does not match argument name `p1`.
          #
          def xxx(p1, p2)
                      ^^ Parameter size `1` does not match argument size `2`.
          end
        end
      RUBY
    end
    it 'Wrong number of parms; second parm correct' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          # === Parameters:
          #
          # * <tt>:options</tt>
          ^^^^^^^^^^^^^^^^^^^^^ Parameter name `options` does not match argument name `p1`.
          # * <tt>:p1</tt>
          ^^^^^^^^^^^^^^^^ Parameter name `p1` does not match argument name `p2`.
          #
          def xxx(p1, p2)
          end
        end
      RUBY
    end
    it 'Wrong number of parms; first parm correct' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          # === Parameters:
          #
          # * <tt>:p1</tt>
          # * <tt>:options</tt>
          ^^^^^^^^^^^^^^^^^^^^^ Parameter name `options` does not match argument name `p2`.
          #
          def xxx(p1, p2)
          end
        end
      RUBY
    end
    it 'parms in wrong order' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          # === Parameters:
          #
          # * <tt>:p2</tt>
          ^^^^^^^^^^^^^^^^ Parameter name `p2` does not match argument name `p1`.
          # * <tt>:p1</tt>
          ^^^^^^^^^^^^^^^^ Parameter name `p1` does not match argument name `p2`.
          #
          def xxx(p1, p2)
          end
        end
      RUBY
    end
    it 'parms format is wrong' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          # === Parameters:
          #
          # * <tt>p1</tt>
          ^^^^^^^^^^^^^^^ Illegal Parameter format: '# * <tt>:{argument}</tt> {description}'.
          # <tt>:p2</tt>
          ^^^^^^^^^^^^^^ Illegal Parameter format: '# * <tt>:{argument}</tt> {description}'.
          #
          def xxx(p1, p2)
                  ^^ Parameter size `0` does not match argument size `2`.
          end
        end
      RUBY
    end
    it 'Correct for one parm' do
      expect_no_offenses(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          # === Parameters:
          #
          # * <tt>:p1</tt>
          # * <tt>:p2</tt>
          #
          def xxx(p1, p2)
          end
        end
      RUBY
    end
  end
  describe 'attributes' do
    it 'No attribures nd parms' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          # === Attributes:
          ^^^^^^^^^^^^^^^^^ Attributes and Parameters should not exist on same method.
          #
          # === Parameters:
          #
          # * <tt>:p1</tt>
          # * <tt>:p2</tt>
          #
          def xxx(p1, p2)
          end
        end
      RUBY
    end
    it 'attribures empty body' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          # === Attributes:
          ^^^^^^^^^^^^^^^^^ Attribute body is empty.
          #
          def xxx
          end
        end
      RUBY
    end
    it 'attributes ' do
      expect_no_offenses(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          # === Attributes:
          #
          # * <tt>:id</tt> Candidate id
          #
          def xxx
          end
        end
      RUBY
    end
  end
  describe 'Return' do
    it 'parameters before return' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          ^^^^^^^^^^^^^^^^^^^^^^^ Returns should be last.
          #
          # === Returns:
          #
          # * <tt>Boolean</tt>
          #
          # === Parameters:
          ^^^^^^^^^^^^^^^^^ Parameters should be before Returns.
          #
          # * <tt>:p1</tt>
          # * <tt>:p2</tt>
          #
          def xxx(p1, p2)
          end
        end
      RUBY
    end
    it 'attributes before return' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          ^^^^^^^^^^^^^^^^^^^^^^^ Returns should be last.
          #
          # === Returns:
          #
          # * <tt>Boolean</tt>
          #
          # === Parameters:
          ^^^^^^^^^^^^^^^^^ Parameters should be before Returns.
          #
          # * <tt>:p1</tt>
          # * <tt>:p2</tt>
          #
          def xxx(p1, p2)
          end
        end
      RUBY
    end
    it 'bad return format' do
      expect_offense(<<~RUBY)
        # class doc
        #
        class Admin < ApplicationRecord
          # this is what xxx does
          #
          # === Parameters:
          #
          # * <tt>:p1</tt>
          # * <tt>:p2</tt>
          #
          # === Returns:
          #
          # <tt>Boolean</tt>
          ^^^^^^^^^^^^^^^^^^ Illegal Return format: '# * <tt>{CLASS}</tt> {description}'.
          #
          def xxx(p1, p2)
          end
        end
      RUBY
    end
  end
  describe 'afile' do
    it 'should pass' do
      File.open("lib/rubocop/cop/Style/public_method_documentation.rb") do |f|
        expect_no_offenses(f.read)
      end
    end
    it 'should pass' do
      File.open("lib/rubocop/cop/Style/public_class_documentation.rb") do |f|
        expect_no_offenses(f.read)
      end
    end
  end
end
