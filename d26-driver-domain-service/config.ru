# frozen_string_literal: true

require 'bundler/setup'
require_relative 'config/database'
require_relative 'app/models/driver_schema'
require_relative 'app/models/driver'
require_relative 'app/api/drivers'
require_relative 'app/api/base'

run Base
