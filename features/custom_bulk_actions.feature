Feature: Custom bulk actions
	In order to save time
	As an admin
	I want to be able to make actions to multiple items simultaneously

  Background:
	Given the following people exist
	 | name | address         | phone  |
	 | John | 1 infinite loop | 123456 |
	 | Peter | 2 infinite loop | 45678913 |
    And I am on the people admin page

	Scenario: Delete single records
      And I check "record_0" 
	  And I select "destroy" from "selected_action"
      And I press "Go"
      Then I should not see "John"

    Scenario: Delete multiple records
      And I check "record_0"
      And I check "record_1"
	  And I select "destroy" from "selected_action"
      And I press "Go"
      Then I should see "No people found."
