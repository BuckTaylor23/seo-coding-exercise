# frozen_string_literal: true

module DriverHelper
module_function

  def build_driver(overrides = {})
    FM[:driver].build(attributes: overrides)
  end

  def build_driver_with(given_fields)
    omitted = ALL_DRIVER_FIELDS - given_fields
    overrides = omitted.to_h { |field| [field.to_sym, nil] }
    LOG.info { "Generating driver with following fields: #{given_fields}".cyan }
    build_driver(overrides)
  end

  def build_driver_from_override(field, value)
    value = INVALID_CHARS.sample if value&.downcase&.include?('invalid value')
    LOG.info { "Generating driver with following field: #{field}, set to: #{value}".brown }
    build_driver({ field.to_sym => value })
  end

  def generate_dln_from(driver_details)
    dob = driver_details[:date_of_birth]
    dob = Date.parse(dob) if dob.is_a?(String)
    surname = driver_details[:last_name][0..3].ljust(4, 'X')
    first_name = driver_details[:first_names][0..1].ljust(2, 'X')
    birth_month = dob.month.to_s.rjust(2, '0')
    birth_day = dob.day.to_s.rjust(2, '0')

    "#{surname}#{birth_month}#{birth_day}#{first_name}".upcase
  end

  def generate_random_dln
    surname = Faker::Lorem.characters(number: 4)
    first_name = Faker::Lorem.characters(number: 2)
    birth_month = rand(1..12).to_s.rjust(2, '0')
    birth_day = rand(1..30).to_s.rjust(2, '0')
    tiebreakers = Faker::Lorem.characters(number: 2)

    "#{surname}#{birth_month}#{birth_day}#{first_name}#{tiebreakers}".upcase
  end

  def value_from_driver(value)
    artefacts.driver.as_json.transform_keys(&:to_sym)[value.to_sym]
  end

  def driver_details_update(field)
    case field.downcase
    when 'first_names' then Faker::Name.name_with_middle.tr('.', '')
    when 'last_name' then Faker::Name.last_name
    when 'driving_licence_type'
      value_from_driver(field) == 'Full' ? 'Provisional' : 'Full'
    else
      raise "Unknown update field: #{field}"
    end
  end

  def lookup_driver
    HttpRequestHelper.submit_request_to_endpoint(request_type: 'retrieve driver', body: nil)
  end

  def map_record_for_deletion(incorrect_record: false)
    driver = incorrect_record ? FM[:driver].build : artefacts.driver

    { first_names: driver.first_names,
      last_name: driver.last_name,
      date_of_birth: driver.date_of_birth }
  end
end
