# frozen_string_literal: true

class Driver
  MAX_RETRIES = 10

  def self.generate_unique_licence_number(**attrs)
    MAX_RETRIES.times do
      candidate = generate_licence_number(**attrs)
      return candidate unless DB[:drivers].where(driving_licence_number: candidate).count.positive?
    end
    raise "Failed to generate unique driving licence number after #{MAX_RETRIES} attempts"
  end

  def self.generate_licence_number(first_names:, last_name:, date_of_birth:, **)
    dob = Date.parse(date_of_birth)
    last = pad_name(last_name, 4)
    first = pad_name(first_names, 2)
    random = Array.new(2) { ('A'..'Z').to_a.sample }.join
    "#{last}#{format('%02d', dob.month)}#{format('%02d', dob.day)}#{first}#{random}"
  end

  def self.pad_name(name, length)
    name.gsub(/[^a-zA-Z]/, '').upcase.ljust(length, 'X')[0, length]
  end
end
