# frozen_string_literal: true

require 'rspec'
require_relative 'allure_helper'
require_relative 'driver_helper'

module SpecHelper

  AllureHelper.configure
  RSpec.configure do |config|
    config.formatter = AllureHelper.formatter
    config.include(DriverHelper)
    config.before(:each) do
      driver.manage.window.maximize
    end

    config.after(:each) do
      example_name = self.class.descendant_filtered_examples.first.description
      driver.save_screenshot("allure-results/screenshots/#{example_name}.png")
       AllureHelper.add_screenshot example_name
      driver.quit
    end
  end
end
