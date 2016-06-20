# HellRaiser

Vulnerability Scanner

![Alt text](https://github.com/m0nad/HellRaiser/blob/master/doc/result00.png)

# Install

Install ruby, bundler and rails.
https://gorails.com/setup/ubuntu/16.04

Install redis-server and nmap.
```
sudo apt-get update
sudo apt-get install redis-server nmap
```
Clone HellRaiser repository, change to hellraiser web app directory and run bundle install.
```
git clone https://github.com/m0nad/HellRaiser/
cd HellRaiser/hellraiser/
bundle install
```

# Start

Start redis server.
```
redis-server
```

Go to the hellraiser web app directory and start sidekiq.
```
bundle exec sidekiq
```

Go to the hellraiser web app directory and start rails server.
```
rails s
```

# Usage

Access http://127.0.0.1:3000

# How it works?

HellRaiser scan with nmap then correlates cpe's found with cve-search to enumerate vulnerabilities.
