Feature: 02 Retrieve Driver

  As a consumer of the Driver Domain Service
  I want to retrieve a driver record by driving licence number
  So that I can view the details of an existing driver

  @positive
  Scenario: AC1 - Successful retrieval of driver record
    Given a driver exists in the driver domain system
    When the retrieve driver request is submitted with the existing DLN
    Then a 200 OK response is returned
    And the response contains the correct driver record

  @negative
  Scenario: AC2 - Driver not found
    Given a request contains non existing driver
    When the retrieve driver request is submitted with the non-existing DLN
    Then a 404 Not Found response is returned
    And the response contains the error:
      | error            |
      | Driver not found |