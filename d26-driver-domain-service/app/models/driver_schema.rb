# frozen_string_literal: true

require 'easy_talk'

class DriverSchema
  include EasyTalk::Model

  define_schema do
    title 'Driver'
    property :first_names, String, max_length: 32, pattern: /\A[a-zA-Z\s'-]+\z/
    property :last_name, String, max_length: 32, pattern: /\A[a-zA-Z\s'-]+\z/
    property :date_of_birth, String, pattern: /\A\d{4}-\d{2}-\d{2}\z/
    property :driving_licence_type, String, enum: %w[Full Provisional]
    property :driving_licence_number, String, optional: true
  end

  validate :validate_age

  private

  def validate_age
    return if date_of_birth.nil?

    dob = Date.parse(date_of_birth)
    today = Date.today
    errors.add(:date_of_birth, 'must be at least 17 years old') if dob > today.prev_year(17)
    errors.add(:date_of_birth, 'must be no older than 100 years old') if dob < today.prev_year(100)
  end
end
