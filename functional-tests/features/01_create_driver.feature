Feature: 01 Create Driver

  As a consumer of the Driver Domain Service
  I want to create a new driver record
  So that driver information can be stored correctly and referenced for future transactions

  @positive
  Scenario: AC1 - Successful driver creation with all required fields
    Given a valid request contains the following fields:
      | first_names          |
      | last_name            |
      | date_of_birth        |
      | driving_licence_type |
    When the create driver request is submitted
    Then a 201 Created response is returned
    And the response contains the correct driver record
    And the driver licence number is generated correctly

  @positive
  Scenario: AC2 - Successful driver creation with all required fields and DLN
    Given a valid request contains the following fields:
      | first_names            |
      | last_name              |
      | date_of_birth          |
      | driving_licence_type   |
      | driving_licence_number |
    When the create driver request is submitted
    Then a 201 Created response is returned
    And the response contains the correct driver record

  @negative
  Scenario Outline: AC3 - Required field validation
    Given a request where the <field> field is <condition>
    When the create driver request is submitted
    Then a <error> response is returned

    Examples:
      | field       | condition  | error                     |
      | first_names | missing    | 400 Bad Request           |
      | first_names | empty      | 422 Unprocessable Content |
      | first_names | overlength | 422 Unprocessable Content |
      | last_name   | missing    | 400 Bad Request           |
      | last_name   | empty      | 422 Unprocessable Content |
      | last_name   | overlength | 422 Unprocessable Content |

  @negative
  Scenario Outline: AC4 - Field format validation
    Given a request where the <field> field contains an invalid value
    When the create driver request is submitted
    Then a 422 Unprocessable Content response is returned

    Examples:
      | field       |
      | first_names |
      | last_name   |

  Scenario: AC5 - Date of birth format validation
    Given a request where the date_of_birth field is wrong format
    When the create driver request is submitted
    Then a 422 Unprocessable Content response is returned
    And the response contains the errors:
      | errors                   |
      | Date of birth is invalid |


  @negative
  Scenario Outline: AC6 - Age validation
    Given a request contains a driver <age>
    When the create driver request is submitted
    Then a 422 Unprocessable Content response is returned
    And the response contains the errors:
      | errors  |
      | <error> |

    Examples:
      | age      | error                                             |
      | under 17 | Date of birth must be at least 17 years old       |
      | over 100 | Date of birth must be no older than 100 years old |

  @negative
  Scenario: AC7 - Driving licence type validation
    Given a request where the driving_licence_type field is invalid
    When the create driver request is submitted
    Then a 422 Unprocessable Content response is returned
    And the response contains the errors:
      | errors                                                 |
      | Driving licence type must be one of: Full, Provisional |
