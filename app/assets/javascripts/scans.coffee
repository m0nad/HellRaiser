# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.datatable').DataTable({
    processing: true,
    serverSide: true,
    ajax: $('.datatable').data('api'),
    columnDefs: [{ width: '25%', className: "text-right", orderable: false, targets: -1 }],
    dom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    pagingType: "full_numbers"
  });
