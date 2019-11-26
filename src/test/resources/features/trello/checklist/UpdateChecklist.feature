Feature: Update a Checklist of a Card

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board1 created by cucumber"
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
    "name": "Card1",
    "desc": "card1 was created by automation",
    "idList": "(L.id)"
    }
    """
    And I save the response as "C"
    And I validate the response has status code 200
    And I send a "POST" request to "/checklists" with json body
    """
    {
    "name": "Task_1",
    "idCard": "(C.id)",
    "idBoard": "(CB.id)",
    "idChecklistSource": ""
    }
    """
    And I validate the response has status code 200
    And I save the response as "Ch"

  @cleanData
  Scenario Outline: Update a Checklist
    When I send a "PUT" request to "/checklists/{Ch.id}"
    """
    {
    "name": "<value>"
    }
    """
    Then I validate the response has status code 200
    And I validate the response contains:
      | <key> | <value> |

    Examples:
      | key   | value           |
      | name  | Task         1  |
      | name  | T@$k_#1%^&*     |

