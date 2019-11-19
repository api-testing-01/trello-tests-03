Feature: Organizations

  Background:
    Given I use the "trello" service and the "owner" account

  @cleanData
  Scenario:
    When I send a "POST" request to "/organizations" with json body
    """
    {
    "displayName": "apiTest03",
    "desc": "something"
    }
    """
    Then I save the response as "Team"
    And I save the request endpoint for deleting
    And I validate the response has status code 200
    And I validate the response contains "displayName" equals "apiTest03"
    And I validate the response contains "desc" equals "something"
