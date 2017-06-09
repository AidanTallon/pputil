class RadioButton < Qt::RadioButton
	attr_reader :value

	def initialize(text, value, parent)
		super(text, parent)
		@value = value
	end
end