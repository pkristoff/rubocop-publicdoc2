# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Style::PublicClassDocumentation, :config do
  let(:config) { RuboCop::Config.new(RuboCop::Publicdoc2::CONFIG) }

  it 'Missing class documentation' do
    expect_offense(<<~RUBY)
  class Admin < ApplicationRecord
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Missing class documentation
  end
    RUBY
  end

  it 'has class documentation' do
    expect_no_offenses(<<~RUBY)
  # class doc
  #
  class Admin < ApplicationRecord
  end
    RUBY
  end

  it 'last line should be comment symbol only' do
    expect_offense(<<~RUBY)
  # class doc
  # vvvvv
  ^^^^^^^ Class documentation should end with an empty line
  class Admin < ApplicationRecord
  end
    RUBY
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
