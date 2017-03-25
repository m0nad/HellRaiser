require 'hellraiser'

class Hellraiserasync
  include Sidekiq::Worker
  def save_to_json(hosts, filename)
    File.open(filename, "w") do |f|
      f.write(hosts.to_json)
    end
  end

  def perform(id)
    scan = Scan.find(id)
    scan.running!

    filename = HellRaiser.configuration.output_dir + scan.id.to_s
    nmap_opts = HellRaiser.configuration.nmap_default_opts
    nmap_opts['output_all'] = filename
    nmap_opts['targets'] = scan.target
    # portscan
    portscan = HellRaiser::PortScan.new
    if nmap_opts['sudo']
      portscan.sudo_scan(nmap_opts)
    else
      portscan.scan(nmap_opts)
    end
    # cve scan
    hellraiser = HellRaiser::CveSearch.new
    result = hellraiser.scan(filename + '.xml')
    save_to_json(result, filename + '.json')
    # change status to fished
    scan.status = 2
    scan.save
    redis.set id, filename + '.json' # id from database and filename
  end

  def redis
    @redis ||= Redis.new
  end
end
