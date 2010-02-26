Feature: Fulltext search filter
  In order to save time
  As an admin
  I want to be able to search for record using fulltext queries

  Scenario: Search finds one match
    Given the following "articles" exist
      | title | body |
      | Mysql | a database |
      | Ruby | awesome programming language |
    And I am on the articles admin page
    And I fill in "q" with "ruby"
    And I press "Search"
    Then I should see "Ruby"
    And I should not see "Mysql"

  Scenario: Search finds no matches
    Given the following "articles" exist
      | title | body |
      | Mysql | a database |
      | Ruby | awesome programming language |
    And I am on the articles admin page
    And I fill in "q" with "test"
    And I press "Search"
    Then I should see "No matching articles found. List all articles."

