class Scripts
	def self.login(opt = {})
		Browser.new(opt[:browser]).login_as_admin.keep_open
	end

	def self.add_auth_member(opt = {})
		Browser.new(opt[:browser]).add_auth_member.keep_open
	end

	def self.add_unauth_member(opt = {})
		Browser.new(opt[:browser]).add_unauth_member.keep_open
	end
end