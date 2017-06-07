class Browser
	def login_as_admin
		@browser.goto @yaml['url']
		@browser.frame(name: 'ContentFrame').frame(name: 'ActiveAreaFrame').text_field(id: 'UserName').set @yaml['admin_username']
		@browser.frame(name: 'ContentFrame').frame(name: 'ActiveAreaFrame').text_field(type: 'password').set(@yaml['admin_password'])
		@browser.frame(name: 'ContentFrame').frame(name: 'ActiveAreaFrame').text_field(type: 'password').send_keys(:enter)
		return self
	end
end