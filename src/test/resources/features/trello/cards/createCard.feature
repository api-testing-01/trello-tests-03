Feature: Create cards on a board

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

  @cleanData
  Scenario Outline: Create card
    When I send a "POST" request to "/cards" with json body
    """
    {
    "name": "<cardName>",
    "desc": "<cardDescription>",
    "idList": "(L.id)"
    }
    """
    And I save the response as "C"
    Then I validate the response has status code 200
    And I validate the response contains:
      | name | <cardName>        |
      | desc | <cardDescription> |

    Examples:
      | cardName | cardDescription              |
      | card     | card1 created by cucumber    |
      | c@rd     | card with special characters |
      | c ard    | card with blank spaces       |
      | card1    | card with numbers on name    |

    