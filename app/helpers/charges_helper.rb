module ChargesHelper
	def get_stripe_settings
		settings = YAML.load_file("config/stripe_settings.yml")		
	end
end
