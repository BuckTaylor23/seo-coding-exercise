# frozen_string_literal: true

require 'grape'

class Base < Grape::API
  format :json
  prefix :api
  version 'v1', using: :path

  mount Drivers
end
