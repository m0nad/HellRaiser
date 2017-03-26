class ApplicationDatatable < AjaxDatatablesRails::Base
  def sort_records(records)
    sort_by = []
    params[:order].each do |key, item|
      sort_by << "#{sort_column(item)} #{sort_direction(item)}"
    end
    records.order(sort_by.join(", "))
  end

  def generate_sortable_displayed_columns
    @sortable_displayed_columns = []
    params[:columns].each do |key, column|
      @sortable_displayed_columns << column[:data] if column[:orderable] == 'true'
    end
    @sortable_displayed_columns
  end
end
