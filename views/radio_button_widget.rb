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