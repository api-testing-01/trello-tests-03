#Feature: Organizations
#
#  Background:
#    Given I use the "trello" service and the "owner" account
#
#  @cleanData
#  Scenario Outline: Create an organization
#    When I send a "POST" request to "/organizations" with json body
#    """
#    {
#    "displayName": "<displayName>",
#    "desc": "<description>",
#    "name": "<name>",
#    "website": "<website>"
#    }
#    """
#    Then I save the response as "Team03"
#    And I save the request endpoint for deleting
#    And I validate the response has status code 200
#    And I validate the response contains:
#      | displayName | <displayName> |
#      | desc        | <description> |
#      | name        | <name>        |
#      | website     | <website>     |
#
#    Examples:
#      | displayName             | description           | name          | website                  |
#      | Api Testing 03          | Automation Course     | at03          | https://www.amazon.com/  |
#      | Api Without Description |                       | awd03         | https://www.amazon.com/  |
#      | Api Testing 03          | with name by default  | apitesting03  | https://www.amazon.com/  |
#      | Api Testing 03          | without website       | at03ww        | null                     |
