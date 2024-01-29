# frozen_string_literal: true

require 'rspec'
require 'tmpdir'
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

    config.after(:each) do |example|
      example_name = example.description
      Dir.mktmpdir do |temp_folder|
        screenshot = driver.save_screenshot("#{temp_folder}/#{example_name}.png")
        AllureHelper.add_screenshot(example_name, screenshot)
      end
      driver.quit
    end
  end
end
