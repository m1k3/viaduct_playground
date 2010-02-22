Feature: Scaffold for a model with no relationships
	So that I can see that viaduct works
	As an admin
	I want to see people admin pages

Background: people exist
	Given the following people exist
	 | name | address         | phone  |
	 | John | 1 infinite loop | 123456 |
	 | Peter | 2 infinite loop | 45678913 |
    And I am on the people admin page
	
	Scenario: List people
		Then I should see "name"
		And I should see "John"
		And I should see "Peter"
		And I should see "New Person"
		And I should not see "1 inifinite loop"
		And I should not see "2 inifinite loop"
		And I should not see "123456"
		And I should not see "456789123"
	
	Scenario: Create a new person
		When I follow "New Person"
		When I fill in "name" with "Adam"
		And I fill in "address" with "1 infinite loop"
		And I fill in "phone" with "123456"
		And I press "submit"
		Then I should see "Person was successfully created"
		And I should see "Adam"
		And I should have 3 person/people
	
	Scenario: Edit a person
		When I follow "Edit" within "table tr:nth-of-type(2)"
		And I fill in "name" with "Adam"
		And I fill in "address" with "3 infinite loop"
		And I fill in "phone" with "45612987"
		And I press "submit"
		Then I should see "Person was successfully updated."
		And I should see "Adam"
		And I should have 2 person/people

    Scenario: Invalid person creation
        When I follow "New Person"
		And I press "submit"
		And I should see "Name can't be blank"
		And I should see "Address can't be blank"