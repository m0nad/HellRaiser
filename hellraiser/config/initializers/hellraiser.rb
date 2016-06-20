require 'yaml'
module HellRaiser
	class << self
		attr_accessor :configuration
	end

	def self.configure
		self.configuration ||= Configuration.new
		yield(configuration)
	end

	class Configuration
		attr_accessor :cve_id_url, :cvesearch_api_domain, :gitedb_url, :gitmsf_url, :edb_url, :output_dir, :nmap_default_opts
	end
end

config_yml = YAML.load_file(File.expand_path('../config.yml', File.dirname(__FILE__)))
HellRaiser.configure do |config|
	config.cve_id_url = config_yml['cve_id_url']
	config.cvesearch_api_domain = config_yml['cvesearch_api_domain']
	config.gitedb_url = config_yml['gitedb_url']
	config.gitmsf_url = config_yml['gitmsf_url']
	config.edb_url = config_yml['edb_url']
	config.output_dir = config_yml['output_dir']
	config.nmap_default_opts = config_yml['nmap_default_opts']
end
