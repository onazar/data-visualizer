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
      null

  $scope.drawPassingFailingChart = (data) ->
    $scope.passingFailingChart = chartService.buildPassingFailingChart(data)

  $scope.drawBuildDurationChart = (data) ->
    $scope.buildDurationChart = chartService.buildBuildDurationChart(data)

  $scope.changeSeriesVisibility = (chart, selectedItem) ->
    chartService.changeSeriesVisibility(chart, selectedItem)

  # initial load
  $scope.getData().then (data) ->
    return null unless data?
    $scope.drawPassingFailingChart(data)
    $scope.drawBuildDurationChart(data)
    $timeout ->
      $scope.loading = false
    , 500

# this method is not used currently, but it is likely that it will be needed in the future.
#  $scope.redrawCharts = ->
#    $scope.getData().then (data) ->
#      if data?
#        $scope.drawPassingFailingChart(data)
#        $scope.drawBuildDurationChart(data)

]
