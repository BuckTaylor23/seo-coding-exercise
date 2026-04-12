# frozen_string_literal: true

require 'easy_talk'

class DriverUpdateSchema
  include EasyTalk::Model

  define_schema do
    title 'Driver'
    property :first_names, String, max_length: 32, pattern: /\A[a-zA-Z\s'-]+\z/, optional:true
    property :last_name, String, max_length: 32, pattern: /\A[a-zA-Z\s'-]+\z/, optional:true
    property :date_of_birth, String, pattern: /\A\d{4}-\d{2}-\d{2}\z/, optional:true
  end
end
