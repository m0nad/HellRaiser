class ScanDecorator < Draper::Decorator
  delegate_all

  def status
    case scan.status
    when 'queued'
      h.icon('link', scan.status.titleize)
    when 'running'
      h.icon('refresh', scan.status.titleize, class: 'fa-spin')
    when 'finished'
      h.icon('check', scan.status.titleize)
    end
  end

  def actions
    "#{run_link} #{show_link} #{object.finished? ? destroy_link : cancel_link}"
  end

  def run_link
    h.link_to h.icon('flag-checkered', 'Run'), scan, method: :put, remote: true, class: 'btn btn-xs btn-success'
  end

  def show_link
    h.link_to h.icon('file-text', 'Show'), scan, class: 'btn btn-xs btn-primary'
  end

  def destroy_link
    h.link_to h.icon('trash', 'Delete'), scan, method: :delete, remote: true, class: 'btn btn-xs btn-danger', data: { confirm: 'Are you sure?' }
  end

  def cancel_link
    h.link_to h.icon('trash', 'Cancel'), scan, method: :delete, remote: true, class: 'btn btn-xs btn-danger', data: { confirm: 'Are you sure?' }
  end

end
