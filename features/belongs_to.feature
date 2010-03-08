Feature: Associate a model via a belongs_to association
	So that I can associate a model with another via a belongs_to association
	As an admin
	I want to execute the association

Background: people exist
	Given the following "people" exist
	 | name  | address         | phone    |
	 | John  | 1 infinite loop | 123456   |
	 | Peter | 2 infinite loop | 45678913 |
	And the following "comments" exist
	 | title   | content   |
	 | title 1 | content 1 |
	 | title 2 | content 2 |
	And the following "AudioRecordings" exist
	 | title   | content   |
	 | audio title 1 | content 1 |
	 | audio title 2 | content 2 |
	And the following "VideoRecordings" exist
	 | title   | content   |
	 | video title 1 | content 1 |
	 | video title 2 | content 2 |
    And I am on the comments admin page


	Scenario: Adding the association to an existing model
		When I follow "Edit" within "html>body>div>form>table tr>td:nth-of-type(3)"
		And fill in "person" with "John"
		And I press "submit"
		And I should see "Comment was successfully updated."
		And I follow "Edit" within "html>body>div>form>table tr>td:nth-of-type(3)"
		Then the "person" field should contain "John" 
		
	Scenario: Adding the association to an new model
		When I follow "New Comment"
		And I fill in "title" with "title 3"
		And I fill in "content" with "content 3"
		And I fill in "person" with "John"
		And I press "submit"
		And I should see "Comment was successfully created."
		And I follow "Edit" within "html>body>div>form>table tr:nth-of-type(3)>td:nth-of-type(3)"
		Then the "person" field should contain "John"
		
	Scenario: Adding a polymorhic association to an existing model
		And I am on the people admin page
		When I follow "Edit" within "table tr:nth-of-type(2)"
		And I fill in "name" with "Adam"
		And I fill in "address" with "3 infinite loop"
		And I fill in "phone" with "45612987"
		And I fill in "recording" with "audio title 1"
		And I press "submit"
		And I follow "Edit" within "table tr:nth-of-type(2)"
		Then the "recording" field should contain "audio title 1"
		And I should have 2 person/people
	
	Scenario: Adding a polymorphic association to a new model
		And I am on the people admin page
		When I follow "New Person"
		When I fill in "name" with "Adam"
		And I fill in "address" with "1 infinite loop"
		And I fill in "phone" with "123456"
		And I fill in "recording" with "video title 1"
		And I press "submit"
		And I follow "Edit" within "table tr:nth-of-type(3)"
		Then the "recording" field should contain "video title 1"
		And I should have 3 person/people