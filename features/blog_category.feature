Feature: Blog Categories
  
  As an avid lover of organization
  and a power hungry admin
  I want the ability to lord over the creation and edit of Blog Categories
  
  Scenario: Open the Categories Page
    Given the blog is set up
    And I am logged into the admin panel
    When I follow "Categories"
    Then I should be on the Categories page