class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :invite, optional: true
  belongs_to :invite_comment, optional: true
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true

  # visitor = 通知を送ったユーザー
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  # visited = 通知を送られたユーザー
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  # [optional: true]はnilを入れるために記述
end
