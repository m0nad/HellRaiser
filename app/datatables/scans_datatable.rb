class ScansDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    @sortable_columns ||= %w(Scan.title Scan.target Scan.status)
  end

  def searchable_columns
    @searchable_columns ||= %w(Scan.title Scan.target Scan.status)
  end

  private

  def data
    records.map do |record|
      [
        record.title,
        record.target,
        record.decorate.status,
        record.decorate.actions
      ]
    end
  end

  def get_raw_records
    options[:records] || Scan.all
  end
end
