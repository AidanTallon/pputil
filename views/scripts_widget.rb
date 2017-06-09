class ScriptsWidget < Qt::Widget
	signals 'clicked()'
	slots 'runScript()'

	def initialize(parent)
		@parent = parent
		super
		@layout = Qt::VBoxLayout.new
		@buttons = []

		scripts = Scripts.methods - Object.methods

		scripts.each do |script|
			btn = ScriptButton.new script.to_s, self
			@buttons << btn
		end

		@buttons.each do |btn|
			@layout.addWidget btn
		end		

		setLayout @layout
	end

	def runScript
		btn = sender
		path = btn.script

		EnvConfig.select_env @parent.env_radios.selected_value.to_s

		browser = Browser.new @parent.browser_radios.selected_value

		Thread.new { Scripts.send path, browser }
	end
end