app.service 'chartService', [ ->

  # why 'frequencies', when it is 'failingFrequencies'? Because it can by pretty much anything,
  # the comparison is made only between the values of this hash and its median.
  # For example, it can be successful/failing ratio. See also 'getMedian' method.
  frequencies = {}

  passingFailingChart = {
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

  buildDurationChart = {
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

  successfull = failed = error = stopped = 0

  buildCharts = (rawData) ->
    date = shortDate(rawData[0].createdAt)
    initializeCounters()
    for build in rawData
      pushRowToBuildDurationChart(build.sessionId, build.duration)
      shortBuildDate = shortDate(build.createdAt)
      if date.getTime() == shortBuildDate.getTime()
        countStatus(build.status)
      else
        frequencies[date] = failed + error + stopped
        pushRowToPassingFailingChart(date, successfull, failed, error, stopped)
        date = shortBuildDate
        initializeCounters()
        countStatus(build.status)
    # push last day
    frequencies[date] = failed + error + stopped
    pushRowToPassingFailingChart(date, successfull, failed, error, stopped)
    setAnnotationsToPassingFailingChart()
    return {
      passingFailingChart: passingFailingChart
      buildDurationChart: buildDurationChart
    }


  pushRowToPassingFailingChart = (date, successfull, failed, error, stopped) ->
    passingFailingChart.data.rows.push(
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
        v: ''
      ,
        v: ''
      ]
    )

  pushRowToBuildDurationChart = (sessionId, duration) ->
    buildDurationChart.data.rows.push(
      c: [
        v: sessionId
      ,
        v: duration
        f: "#{duration}"
      ]
    )

  initializeCounters = -> successfull = failed = error = stopped = 0

  countStatus = (status) ->
    switch status
      when 'passed' then ++successfull
      when 'failed' then ++failed
      when 'error' then ++error
      when 'stopped' then ++stopped

  shortDate = (longDateString) -> new Date(longDateString.substr(0, 10).replace(/-/g, ','))

  getMedian = (values) ->
    # reject 0 because it is not 'normal', but 'perfect'
    values = values.filter (e) -> e > 0
    values.sort (a, b) -> a - b
    half = Math.floor(values.length / 2)
    if values.length % 2
      values[half]
    else
      Math.round((values[half-1] + values[half]) / 2.0)

  setAnnotationsToPassingFailingChart = ->
    failingMedian = getMedian(Object.keys(frequencies).map((key) -> frequencies[key]))
    for row in passingFailingChart.data.rows
      # if today failing rate higher than usually
      if frequencies[row.c[0].v] > failingMedian
        annotation = 'W!'
        annotationText = "
              <p><b>Failing rate higher than usually</b></p>
            <div class=\"annotation-popover\">
              <p>Details:</p>
              <ul>
                <li>Current usual fails/day rate: #{failingMedian}</li>
                <li>Date: #{row.c[0].v.toDateString()}</li>
                <li>Successfull: #{row.c[1].v} builds</li>
                <li>Failed: #{row.c[2].v} builds</li>
                <li>With errors: #{row.c[3].v} builds</li>
                <li>Stopped: #{row.c[4].v} builds</li>
              </ul>
            </div>"
        row.c[5].v = annotation
        row.c[6].v = annotationText

  return {
    buildCharts: buildCharts
  }
]
