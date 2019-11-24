Feature: Create cards on a board

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
    {
    "name": "Board0001 created by cucumber"
    }
    """
    And I save the response as "B"
    And I send a "Post" request to "/lists" with datatable
    |idBoard| (B.id)|
    |name   |firstList|
    And I save the response as "L"
    And I send a "Post" request to "/cards" with datatable
     |idList|(L.id)|

    Scenario: Create card
      Given I send a "POST" request to "/cards" with datatable
      |name| new card|
      |idList|(L.id) |
    