@vcr
Feature: Heroku provider

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
    Then I should have a drain with the url "https://www.google.com" on the heroku app called "rally-test-app"

  Scenario: Adding the hipchat deploy hook
    Given I run the following:
      """
      heroku.app('rall-test-app') do |app|
        app.hook :hipchat
      end
      """
