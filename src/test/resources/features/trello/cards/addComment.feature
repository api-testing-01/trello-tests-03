Feature: add comments into a card

  Background: precoditions
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Sprint 1"
    }
    """
    And I save the response as "B"
    And I save the request endpoint for deleting
    And I send a "POST" request to "/lists" with json body
    """
    {
    "name": "To_Do",
    "idBoard": "(B.id)"
    }
    """
    And I save the response as "L"
    And I send a "POST" request to "/cards" with json body
    """
    {
    "name": "task 1",
    "desc": "task for testing new feature",
    "idList": "(L.id)"
    }
    """
    And I save the response as "C"

  @cleanData
  Scenario Outline: Add comments
    When I send a "POST" request to "/cards/{C.id}/actions/comments" with json body
    """
    {"text" : "<comment>"}
    """
    And I save the response as "M"
    Then I validate the response has status code 200
    And I validate the response contains "data.text" equals "<comment>"

    Examples:
      | comment                |
      | this is a comment test |
      | @@@@                   |
      | 1234                   |
