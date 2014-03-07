@vcr
Feature: Runner

  Scenario: Creating an app
    Given I run the following:
      """
      heroku.app('rally-test-app')
      """
    Then I should have a heroku app called "rally-test-app"

  Scenario: Adding a drain to an app
    Given I run the following:
      """
      heroku.app('rally-test-app') do |app|
        app.drain 'https://www.google.com'
      end
      """
