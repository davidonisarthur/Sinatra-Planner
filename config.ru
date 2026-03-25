Dir.glob('./config/initializers/*.rb').each { require it }

require_relative 'app/models/application_base_model'
Dir.glob('./app/models/*.rb').each { require it }

require_relative 'app/controllers/application_controller'
Dir.glob('./app/controllers/*.rb').each { require it }

require './config/routes'

run Sinatra::Application
