# frozen_string_literal: true

ALL_DRIVER_FIELDS = %w[
first_names
last_name
date_of_birth
driving_licence_type
driving_licence_number
].freeze

INVALID_CHARS = %w_! @ # $ % ^ & * ( ) + = [ ] { } | \\ : ; " < > , . ? / ~ `_.freeze

HTTP_METHODS = {
  'post' => HTTParty.method(:post),
  'get' => HTTParty.method(:get),
  'patch' => HTTParty.method(:patch),
  'delete' => HTTParty.method(:delete),
}.freeze

OPTIONAL_UPDATE_FIELDS = %w[
first_names
last_name
driving_licence_type
].freeze
