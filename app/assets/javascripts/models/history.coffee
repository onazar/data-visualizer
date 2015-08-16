app.factory 'History', ['AppModel', (AppModel) ->

  class History extends AppModel
    @configure url: '/history'
]