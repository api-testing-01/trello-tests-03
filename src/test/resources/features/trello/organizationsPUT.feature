Feature: Organizations

  Background:
    Given I use the "trello" service and the "owner" account
    When I send a "POST" request to "/organizations" with json body
    """
    {
    "displayName": "Api Testing 03",
    "desc": "automation course",
    "name": "at03",
    "website": "https://www.amazon.com/"
    }
    """
    And I save the response as "Team03"
    And I save the request endpoint for deleting

  @cleanData
  Scenario: Update an organization
    When I send a "PUT" request to "/organizations/{Team03.id}" with json body
    """
    {
    "displayName": "Api Team Updated",
    "desc": "description updated from cucumber steps",
    "name": "at03up",
    "website": "null",
    "prefs/permissionLevel": "public"
    }
    """
    And I validate the response has status code 200
    Then I validate the response contains:
    | displayName           | Api Team Updated                        |
    | desc                  | description updated from cucumber steps |
    | name                  | at03up                                  |
    | website               | null                                    |
    | prefs/permissionLevel | public                                  |

  @cleanData
  Scenario: Add a team member
    When I send a "PUT" request to "/organizations/{Team03.id}/members" with json body
    """
    {
    "id": "(Team03.id)",
    "email": "shekellkan@gmail.com",
    "fullName": "miguel caballero",
    "type": "normal"
    }
    """
    And I validate the response has status code 200
    And I look for in "members" list by attribute and value: "username", "shekellkan" and save as "member01"
    And I send a "GET" request to "/members/{member01.id}"
    And I validate the response has status code 200

