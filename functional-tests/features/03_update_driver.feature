Feature: 03 Update Driver

  As a consumer of the Driver Domain Service
  I want to update an existing driver record
  So that driver information can be kept accurate and up to date

  @positive
  Scenario Outline: AC1 - Successfully update fields
    Given a driver exists in the driver domain system
    And an update request contains <field>
    When the update driver request is submitted with the existing DLN
    Then a 200 OK response is returned
    And the driver record is updated successfully

    Examples:
      | field                |
      | first_names          |
      | last_name            |
      | driving_licence_type |

  @negative
  Scenario: AC2 - Update submitted with no fields to update
    Given a driver exists in the driver domain system
    And an update request is empty
    When the update driver request is submitted with the existing DLN
    Then a 400 Bad Request response is returned
    And the response contains the error:
      | error                                                                                             |
      | first_names, last_name, driving_licence_type are missing, at least one parameter must be provided |
    And the driver record is unchanged

  @negative
  Scenario: AC3 - Driver not found
    Given a request contains non existing driver
    And an update request contains any update fields
    When the update driver request is submitted with the non-existing DLN
    Then a 404 Not Found response is returned
    And the response contains the error:
      | error            |
      | Driver not found |
