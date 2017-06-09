require 'Qt'
require 'watir'
require 'yaml'
require 'random_word_generator'

Dir['./lib/*.rb'].each { |f| require f }

class Widget < Qt::Widget
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

class RadioButtonWidget < Qt::Widget
	attr_reader :buttons

	def add_button(text, value, opts = {})
		btn = RadioButton.new text, value, self
		@buttons << btn
		btn.checked = true if opts[:default] == true
		@layout.addWidget btn
		setLayout @layout
	end

	def selected_value
		buttons.each do |btn|
			if btn.checked?
				return btn.value
			end
		end
	end

	def initialize(parent)
		super
		@layout = Qt::VBoxLayout.new
		@buttons = []
	end
end

class RadioButton < Qt::RadioButton
	attr_reader :value

	def initialize(text, value, parent)
		super(text, parent)
		@value = value
	end
end

class ScriptButton < Qt::PushButton
	attr_reader :script, :button
	def initialize(script, parent = nil)
		super script, parent
		@script = script
		self.resize 100, 30
		connect(self, SIGNAL('clicked()'), parent, SLOT('runScript()'))
	end
end

app = Qt::Application.new ARGV

widget = Widget.new

widget.show

app.exec
