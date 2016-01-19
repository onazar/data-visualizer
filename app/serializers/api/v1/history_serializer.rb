class Api::V1::HistorySerializer < ActiveModel::Serializer
  attributes :session_id, :created_at, :status, :duration
end