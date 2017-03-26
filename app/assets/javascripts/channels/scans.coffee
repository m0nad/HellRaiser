@App.scans =
  @App.cable.subscriptions.create(
    'ScansChannel',
    received: (data) ->
      $('.datatable').DataTable().draw()
  )
