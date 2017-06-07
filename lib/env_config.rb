class EnvConfig
	@environment_selected

	@yaml_data

	def self.env
		@yaml_data ||= YAML.load(File.new('./data.yml'))
		@yaml_data[@environment_selected]
	end

	def self.select_env(env)
		@environment_selected = env
	end
end
