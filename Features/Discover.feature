Feature: Discover

Scenario: Show Discover
  Given user start the application
  When user land on the Discover list
  Then user should see at least 1 movie in the list
