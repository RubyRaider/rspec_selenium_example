# frozen_string_literal: true

require 'allure-ruby-commons'
require 'allure-rspec'

module AllureHelper
  class << self
    def configure
      AllureRspec.configure do |config|
        config.results_directory = 'allure-results'
        config.clean_results_directory = true
      end
    end

    def add_screenshot(screenshot_name)
      Allure.add_attachment(
        name: name,
        source: File.open("allure-results/screenshots/#{screenshot_name}.png"),
        type: Allure::ContentType::PNG,
        test_case: true
       )
     end

    def formatter
      AllureRspecFormatter
    end
  end
end