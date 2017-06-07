require 'watir'
require 'yaml'

class Browser
	attr_reader :browser

	def initialize(browser)
		if browser == :chrome
			@browser = Watir::Browser.new :chrome, switches: ['--start-maximized']
		elsif browser == :ie
			caps = Selenium::WebDriver::Remote::Capabilities.internet_explorer ignore_zoom_setting: true
			@browser = Watir::Browser.new :ie, desired_capabilities: caps
		else raise 'argumenterror'
		end
		@yaml = EnvConfig.env
	end
end