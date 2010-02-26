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