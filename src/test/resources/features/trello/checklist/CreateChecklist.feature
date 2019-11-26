Feature: Create Checklist on a Card

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board1 created by cucumber"
    }
    """
    And I validate the response has status code 200
    And I save the response as "B"
    And I save the request endpoint for deleting
    And I send a "POST" request to "/lists" with json body
    """
    {
    "name": "To_Do",
    "idBoard": "(B.id)"
    }
    """
    And I validate the response has status code 200
    And I save the response as "L"
    And I send a "POST" request to "/cards" with json body
    """
    {
    "name": "Card1",
    "desc": "card1 was created by automation",
    "idList": "(L.id)"
    }
    """
    And I validate the response has status code 200
    And I save the response as "C"

  @cleanData
  Scenario Outline: Create a Checklist
    When I send a "POST" request to "/checklists" with json body
    """
    {
    "name": "<checklistName>",
    "idCard": "(C.id)",
    "idBoard": "(CB.id)",
    "idChecklistSource": ""
    }
    """
    Then I validate the response has status code 200
    And I save the response as "Ch"
    And I validate the response contains:
      | name | <checklistName>  |

    Examples:
      | checklistName | checklistDescription              |
      | Task         1| Checklist created by automation   |
      | T@$k_#1%^&*   | Checklist with special characters |

