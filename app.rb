require 'Qt'
require 'watir'
require 'yaml'
require 'random_word_generator'

Dir['./lib/*.rb'].each { |f| require f }
Dir['./views/*.rb'].each { |f| require f }

app = Qt::Application.new ARGV

widget = MainWidget.new

widget.show

app.exec
