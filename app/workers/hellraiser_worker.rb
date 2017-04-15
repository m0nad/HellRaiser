require 'hellraiser'

class HellraiserWorker
  include Sidekiq::Worker

  def perform(id)
    return if cancelled?
    scan = Scan.find(id)
    scan.running!
    ActionCable.server.broadcast 'scans', {status: scan.status}

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
    return if cancelled?
    # cve scan
    hellraiser = HellRaiser::CveSearch.new
    result = hellraiser.scan(filename + '.xml')
    save_to_json(result, filename + '.json')
    # change status to fished
    scan.finished!
    ActionCable.server.broadcast 'scans', {status: scan.status}
    redis.set id, filename + '.json' # id from database and filename
  end

  def cancelled?
    Sidekiq.redis {|c| c.exists("cancelled-#{jid}") }
  end

  def self.cancel!(jid)
    Sidekiq.redis {|c| c.setex("cancelled-#{jid}", 86400, 1) }
  end

  def save_to_json(hosts, filename)
    File.open(filename, "w") do |f|
      f.write(hosts.to_json)
    end
  end

  def redis
    @redis ||= Redis.new
  end
end
