Feature: 04 Delete Drivers

  As a consumer of the Driver Domain Service
  I want to delete a driver record
  So that records can be removed when they are no longer required

  @positive
  Scenario: AC1 - Successful deletion
    Given a driver exists in the driver domain system
    And a delete record request contains the correct fields
    When the delete driver request is submitted with the existing DLN
    Then a 204 No Content response is returned
    And the driver record is removed from the database

  @negative
  Scenario: AC2 - Incorrect personal details for driver deletion
    Given a driver exists in the driver domain system
    And a delete record request does not contain the correct fields
    When the delete driver request is submitted with the existing DLN
    Then a 422 Unprocessable Content response is returned
    And the driver record is unchanged

  @negative
  Scenario: AC3 - Driver not found
    Given a request contains non existing driver
    And a delete record request does not contain the correct fields
    When the delete driver request is submitted with the non-existing DLN
    Then a 404 Not Found response is returned
    And the response contains the error:
      | error            |
      | Driver not found |

  @negative
  Scenario: AC4 - Deletion without required fields
    Given a driver exists in the driver domain system
    And an delete request is empty
    When the delete driver request is submitted with the existing DLN
    Then a 400 Bad Request response is returned
    And the response contains the error:
      | error                                                                  |
      | first_names is missing, last_name is missing, date_of_birth is missing |


