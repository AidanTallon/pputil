class Scripts
	def self.login(browser)
		browser.login_as_admin
	end

	def self.add_auth_member(browser)
		browser.login_as_admin unless browser.is_logged_in
		browser.add_member('UAT')
	end

	def self.add_unauth_member(browser)
		browser.login_as_admin unless browser.is_logged_in
		browser.add_member('')
	end
end