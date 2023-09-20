# frozen_string_literal: true
require 'yaml'
require 'active_support/inflector'
require 'selenium-webdriver'

module DriverHelper
    def driver(*opts)
    @driver ||= create_driver(*opts)
  end
  
  private

  def create_driver(*opts)
    @config = YAML.load_file('config/config.yml')
    browser = @config['browser'].to_sym
    Selenium::WebDriver.for(browser, options: browser_options(*opts))
  end

  def browser_options(*opts)
    opts = opts.empty? ? @config['browser_options'] : opts
    create_options(*opts)
  end

  # :reek:FeatureEnvy
  def create_options(*opts)
    load_browser = @config['browser'].to_s
    browser = load_browser == 'ie' ? load_browser.upcase : load_browser.capitalize
    options = "Selenium::WebDriver::#{browser}::Options".constantize.new
    opts.each { |option| options.add_argument(option) }
    options
  end

end
