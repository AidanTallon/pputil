class ScriptButton < Qt::PushButton
	attr_reader :script, :button
	def initialize(script, parent = nil)
		super script, parent
		@script = script
		self.resize 100, 30
		connect(self, SIGNAL('clicked()'), parent, SLOT('runScript()'))
	end
end