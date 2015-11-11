app.controller 'index', [ '$scope', '$timeout', 'History', 'chartService',  ($scope, $timeout, History, chartService) ->

  # hide charts and show loaging gif
  $scope.loading = true

  $scope.getData = ->
    History.get().then (response) ->
      if response.length == 0
        $scope.warningText = 'There is no data to display'
        return null
      response
    ,(errorResponse) ->
      $scope.errorText = "Sorry, but an error occurred: #{errorResponse.statusText}"
      return null

  $scope.drawPassingFailingChart = (data) ->
    $scope.passingFailingChart = chartService.buildPassingFailingChart(data)

  $scope.drawBuildDurationChart = (data) ->
    $scope.buildDurationChart = chartService.buildBuildDurationChart(data)

#  hide/show series on the Passing/Failing chart
  $scope.hideSeries = (selectedItem) ->
    return unless selectedItem?
    col = selectedItem.column
#    filter only clicks on the right section of the chart
    if selectedItem.row == null
      if $scope.passingFailingChart.view.columns[col] == col
        $scope.passingFailingChart.view.columns[col] = {
          label: $scope.passingFailingChart.data.cols[col].label
          type: $scope.passingFailingChart.data.cols[col].type
        }
        $scope.passingFailingChart.options.colors[col - 1] = '#CCCCCC'
      else
        $scope.passingFailingChart.view.columns[col] = col
        $scope.passingFailingChart.options.colors[col - 1] = $scope.passingFailingChart.options.defaultColors[col - 1]

  #  initial load
  $scope.getData().then (data) ->
    return null unless data?
    $scope.drawPassingFailingChart(data)
    $scope.drawBuildDurationChart(data)
    $timeout ->
      $scope.loading = false
    , 500

# this method is not used now, but it is likely that it will be needed in the future.
#  $scope.redrawCharts = ->
#    $scope.getData().then (data) ->
#      if data?
#        $scope.drawPassingFailingChart(data)
#        $scope.drawBuildDurationChart(data)

]
