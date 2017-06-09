class MainWidget < Qt::Widget
	attr_reader :browser_radios, :env_radios

	def initialize
		super

		@scripts = ScriptsWidget.new self

		@browser_radios = RadioButtonWidget.new self
		@env_radios = RadioButtonWidget.new self

		@browser_radios.add_button 'Chrome', :chrome, default: true
		@browser_radios.add_button 'Internet Explorer', :ie

		@env_radios.add_button 'UAT', :uat, default: true
		@env_radios.add_button 'PPASS10', :ppass10

		layout = Qt::HBoxLayout.new

		layout.addWidget @env_radios
		layout.addWidget @browser_radios
		layout.addWidget @scripts

		setLayout layout

		self.windowIcon = Qt::Icon.new './ppass.png'
		self.windowTitle = 'PP Utilities'
	end
end