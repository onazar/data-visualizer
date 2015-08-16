app.controller 'index', [ '$scope', '$timeout', 'History',  ($scope, $timeout, History) ->

  # hide charts and show loaging gif
  $scope.loading = true

  $scope.passingFailingChart = {
    type: "ColumnChart"
    data:
      cols: [
          label: "Date"
          type: "date"
        ,
          label: "Successfull"
          type: "number"
        ,
          label: "Failed"
          type: "number"
        ,
          label: "Error"
          type: "number"
        ,
          label: "Stopped"
          type: "number"
        ,
          type: 'string'
          role: 'annotation'
        ,
          type: 'string'
          role: 'annotationText'
          p:
            html:true
      ]
      rows: [
        # insert rows here
      ]
    options:
      bar:
        groupWidth: '90%'
      isStacked: true
      colors: ['#00FF00', '#FF0000', '#FFA500', '#0059FF']
      tooltip:
        isHtml: true
      vAxis:
        title: 'Number of builds'
        gridlines:
          count: 4
      ,
      hAxis:
        title: 'Date'
  }

  $scope.buildDurationChart = {
    type: "AreaChart"
    data:
      cols: [
        label: "Session id"
        type: "number"
      ,
        label: "Duration (seconds)"
        type: "number"
      ]
      rows: [
        # insert rows here
      ]
    options:
      colors: ['#0059FF']
      displayExactValues: false
      vAxis:
        title: 'Build duration'
        gridlines:
          count: 10
      ,
      hAxis:
        title: 'Session id'
  }

  pushRowToPassingFailingChart = (date, successfull, failed, error, stopped) ->
    all = successfull + failed + error + stopped
    badCases = all - successfull
    annotation = annotationText = ''
    if badCases > 0
      if Math.round(all / badCases) < 2
        annotation = 'W!'
        annotationText = "
            <div class=\"annotation-popover\">
              <p><b>Abnormal number of failing builds (more than 50%)</b></p>
              <p>Details:</p>
              <ul>
                <li>Date: #{date.toDateString()}</li>
                <li>Successfull: #{successfull} builds</li>
                <li>Failed: #{failed} builds</li>
                <li>With errors: #{error} builds</li>
                <li>Stopped: #{stopped} builds</li>
              </ul>
            </div>"
    $scope.passingFailingChart.data.rows.push(
      c: [
        v: date
      ,
        v: successfull
        f: "#{successfull} builds"
      ,
        v: failed
        f: "#{failed} builds"
      ,
        v: error
        f: "#{error} builds"
      ,
        v: stopped
        f: "#{stopped} builds"
      ,
        v: annotation
        f: "#{annotation}"
      ,
        v: annotationText
        f: "#{annotationText}"
      ]
    )

  pushRowToBuildDurationChart = (sessionId, duration) ->
    $scope.buildDurationChart.data.rows.push(
      c: [
        v: sessionId
      ,
        v: duration
        f: "#{duration}"
      ]
    )

  successfull = failed = error = stopped = 0

  initializeCounters = -> successfull = failed = error = stopped = 0

  countStatus = (status) ->
    switch status
      when 'passed' then ++successfull
      when 'failed' then ++failed
      when 'error' then ++error
      when 'stopped' then ++stopped

  shortDate = (longDateString) -> new Date(longDateString.substr(0, 10).replace(/-/g, ','))

  History.get().then (response) ->
    if response.length == 0
      $scope.warningText = 'There is no data to display'
      return
    date = shortDate(response[0].createdAt) if response.length > 0
    initializeCounters()
    for build in response
      pushRowToBuildDurationChart(build.sessionId, build.duration)
      shortBuildDate = shortDate(build.createdAt)
      if date.getTime() == shortBuildDate.getTime()
        countStatus(build.status)
      else
        pushRowToPassingFailingChart(date, successfull, failed, error, stopped)
        date = shortBuildDate
        initializeCounters()
        countStatus(build.status)
    # push last day
    pushRowToPassingFailingChart(date, successfull, failed, error, stopped)
    # display charts
    $timeout ->
      $scope.loading = false
    , 500
  ,(errorResponse) ->
    $scope.errorText = "Sorry, but an error occurred: #{errorResponse.statusText}"
]
