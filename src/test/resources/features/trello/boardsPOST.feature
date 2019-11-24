Feature: Boards

  Background:
    Given I use the "trello" service and the "owner" account

  @cleanData
  Scenario Outline: Create a Board
    When I send a "POST" request to "/boards" with json body
    """
    {
    "name": "<name>",
    "prefs_permissionLevel": "<permissionLevel>",
    "prefs_background": "<background>",
    "prefs_voting": "<voting>",
    "prefs_comments": "<comments>"
    }
    """
    And I save the response as "Board01"
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And I validate the response contains:
    | name                  | <name>            |
    | prefs.permissionLevel | <permissionLevel> |
    | prefs.background      | <background>      |
    | prefs.voting          | <voting>          |
    | prefs.comments        | <comments>        |

    Examples:
    |name       | permissionLevel | background  | voting    | comments  |
    | Board0001 | public          | green       | members   | members   |
    | Board0002 | private         | orange      | observers | observers |
    | Board0003 | public          | grey        | public    | disabled  |
