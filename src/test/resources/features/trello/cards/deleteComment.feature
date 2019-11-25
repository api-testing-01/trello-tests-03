Feature: add comments into a card

  Background:
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
    When I send a "POST" request to "/cards/{C.id}/actions/comments" with json body
     """
    {"text" : "this is a comment test"}
    """
    And I save the response as "M"

  @cleanData
  Scenario: delete comments
    When I send a "DELETE" request to "/actions/{M.id}"
    Then I validate the response has status code 200
