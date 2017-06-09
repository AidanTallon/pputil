class Browser
	attr_reader :driver, :is_logged_in

	def initialize(browser)
		if browser == :chrome
			caps = Selenium::WebDriver::Remote::Capabilities.chrome(chrome_options: { detach: true })
			@driver = Watir::Browser.new :chrome, switches: ['--start-maximized'], desired_capabilities: caps
		elsif browser == :ie
			caps = Selenium::WebDriver::Remote::Capabilities.internet_explorer ignore_zoom_setting: true
			@driver = Watir::Browser.new :ie, desired_capabilities: caps
		else raise "#{browser} browser not supported"
		end
		@yaml = EnvConfig.env
		@is_logged_in = false
	end

	def login_as_admin
		@driver.goto @yaml['url']
		@driver.frame(name: 'ContentFrame').frame(name: 'ActiveAreaFrame').text_field(id: 'UserName').set @yaml['admin_username']
		@driver.frame(name: 'ContentFrame').frame(name: 'ActiveAreaFrame').text_field(type: 'password').set @yaml['admin_password']
		@driver.frame(name: 'ContentFrame').frame(name: 'ActiveAreaFrame').text_field(type: 'password').send_keys :enter
		@is_logged_in = true
	end

	def add_member(authCode)
		@driver.goto @yaml['url'] + 'fw1/index.cfm?action=member.addBasicDetails&mode=1'

		@driver.text_field(id: 'forename').set 'Testuser'
		@driver.text_field(id: 'surname').set RandomWordGenerator.word
		@driver.text_field(id: 'countrycode').set 'UK'
		@driver.text_field(id: 'originalsourcecode').set 'WPUN'
		@driver.text_field(id: 'originalsourcecode').send_keys :enter

		@driver.goto @yaml['url'] + 'fw1/index.cfm?action=member.addAddressDetails'

		@driver.text_field(id: 'address1_1').send_keys :enter

		@driver.text_field(id: 'referredBy').send_keys :enter

		@driver.select_list(id: 'ccardType').select_value 'VS'
		@driver.text_field(id: 'ccardNumber').set '4444333322221111'
		@driver.text_field(id: 'ccardExpiry').set '1218'
		@driver.text_field(id: 'creditCardAuthorisationCode').set authCode
		@driver.text_field(id: 'creditCardAuthorisationCode').send_keys :enter

		@driver.goto @yaml['url']

		@driver.frame(name: 'ContentFrame').frame(name: 'NavBarFrame').a(text: 'Membership').click
		@driver.frame(name: 'ContentFrame').frame(name: 'NavBarFrame').a(text: 'Basics').click
	end
end