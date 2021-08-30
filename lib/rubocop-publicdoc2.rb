# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/publicdoc2'
require_relative 'rubocop/publicdoc2/version'
require_relative 'rubocop/publicdoc2/inject'

RuboCop::Publicdoc2::Inject.defaults!

require_relative 'rubocop/cop/publicdoc2_cops'
