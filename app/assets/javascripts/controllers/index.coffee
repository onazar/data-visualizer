app.controller 'index', [ '$scope', '$timeout', 'History', 'chartService',  ($scope, $timeout, History, chartService) ->

  # hide charts and show loaging gif
  $scope.loading = true

  History.get().then (response) ->
    if response.length == 0
      $scope.warningText = 'There is no data to display'
      return
    charts = chartService.buildCharts(response)
    $scope.passingFailingChart = charts.passingFailingChart
    $scope.buildDurationChart = charts.buildDurationChart
    $timeout ->
      # show charts and hide loading gif
      $scope.loading = false
    , 500
  ,(errorResponse) ->
    $scope.errorText = "Sorry, but an error occurred: #{errorResponse.statusText}"

]
