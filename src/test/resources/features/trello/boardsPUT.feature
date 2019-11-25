Feature: Boards

  Background:
    Given I use the "trello" service and the "owner" account
    When I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board0001"
    }
    """
    And I save the response as "Board01"
    And I save the request endpoint for deleting

  @cleanData
  Scenario Outline: Update a Board
    When I send a "PUT" request to "/boards/{Board01.id}" with json body
    """
    {
    "<attribute>": "<value>"
    }
    """
    Then I validate the response has status code 200
    And I validate the response contains:
      | <key>           | <value>            |

    Examples:
    | attribute             | value           | key                   |
    | name                  | Board02 changed | name                  |
    | desc                  | new description | desc                  |
    | prefs/background      | green           | prefs.background      |
    | prefs/voting          | members         | prefs.voting          |
    | prefs/permissionLevel | private         | prefs.permissionLevel |

