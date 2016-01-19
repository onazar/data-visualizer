class Api::V1::HistoryController < Api::V1::BaseController

  def index
    history = History.read
    if history
      render json: history, each_serializer: Api::V1::HistorySerializer
    else
      render nothing: true, status: 500
    end
  end

end