class Browser
	def add_auth_member
		add_member('UAT')
		return self
	end

	def add_unauth_member
		add_member('')
		return self
	end

	private

	def add_member(authCode)
		login_as_admin

		@browser.goto @yaml['url'] + 'fw1/index.cfm?action=member.addBasicDetails&mode=1'

		@browser.text_field(id: 'forename').set 'Test'
		@browser.text_field(id: 'surname').set 'User'
		@browser.text_field(id: 'countrycode').set 'UK'
		@browser.text_field(id: 'originalsourcecode').set 'WPUN'
		@browser.text_field(id: 'originalsourcecode').send_keys :enter

		@browser.goto @yaml['url'] + 'fw1/index.cfm?action=member.addAddressDetails'

		@browser.text_field(id: 'address1_1').send_keys :enter

		@browser.text_field(id: 'referredBy').send_keys :enter

		@browser.select_list(id: 'ccardType').select_value 'VS'
		@browser.text_field(id: 'ccardNumber').set '4444333322221111'
		@browser.text_field(id: 'ccardExpiry').set '1218'
		@browser.text_field(id: 'creditCardAuthorisationCode').set authCode
		@browser.text_field(id: 'creditCardAuthorisationCode').send_keys :enter

		@browser.goto @yaml['url']

		@browser.frame(name: 'ContentFrame').frame(name: 'NavBarFrame').a(text: 'Membership').click
		@browser.frame(name: 'ContentFrame').frame(name: 'NavBarFrame').a(text: 'Basics').click
	end
end
