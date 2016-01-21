app.factory 'History', [ 'AppModel', (AppModel) ->

  class History extends AppModel
    reqConfig = {
      url: '/history'
      httpConfig:
        headers:
          Accept: 'application/json api.data-visualizer.v1'
    }
    @configure(reqConfig)
]