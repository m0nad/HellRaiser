# HellRaiser

Vulnerability Scanner

![Alt text](https://github.com/m0nad/HellRaiser/blob/master/doc/result00.png)

# Install

HellRaiser depends on [cve-search](https://github.com/cve-search/cve-search) API. Have a cve-search API running and add the address in `config/config.yml` on `cvesearch_api_domain` field.

Install ruby 2.7.2, bundler 1.17.3 and rails.
https://gorails.com/setup/ubuntu/20.04

Install redis-server and nmap.
```
sudo apt-get update
sudo apt-get install redis-server nmap
```
Install the foreman gem.
```
gem install foreman
```
Clone HellRaiser repository, change to hellraiser web app directory and run bundle install and bundle exec rake db:migrate.
```
git clone https://github.com/m0nad/HellRaiser/
bundle install
bundle exec rake db:migrate
```

# Start

Start the Procfile using foreman.
```
foreman s
```

# Usage

Access http://127.0.0.1:3000

# How it works?

HellRaiser scan with nmap then correlates cpe's found with cve-search to enumerate vulnerabilities.

# Donate

Support HellRaiser by [donating](https://m0nad.github.io/donate.html).
