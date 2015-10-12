app.controller 'index', [ '$scope', '$timeout', 'History', 'chartService',  ($scope, $timeout, History, chartService) ->

  # hide charts and show loaging gif
  $scope.loading = true

  History.get().then (response) ->
    if response.length == 0
      $scope.warningText = 'There is no data to display'
      return
    charts = chartService.buildCharts(response)
    $scope.passingFailingChart = charts.passingFailingChart
#    chartService.filterChart($scope.passingFailingChart, "Stopped")
    $scope.buildDurationChart = charts.buildDurationChart
    $timeout ->
      # show charts and hide loading gif
      $scope.loading = false
    , 500
  ,(errorResponse) ->
    $scope.errorText = "Sorry, but an error occurred: #{errorResponse.statusText}"

  $scope.hideSeries = (selectedItem) ->
    return unless selectedItem?
    col = selectedItem.column
#    filter only clicks on the right section of the chart
    if selectedItem.row == null
      if $scope.passingFailingChart.view.columns[col] == col
        $scope.passingFailingChart.view.columns[col] = {
          label: $scope.passingFailingChart.data.cols[col].label
          type: $scope.passingFailingChart.data.cols[col].type
#          calc: -> null
        }
        $scope.passingFailingChart.options.colors[col - 1] = '#CCCCCC'
      else
        $scope.passingFailingChart.view.columns[col] = col
        $scope.passingFailingChart.options.colors[col - 1] = $scope.passingFailingChart.options.defaultColors[col - 1]
]
