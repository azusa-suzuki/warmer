class Invite < ApplicationRecord
  enum sex: {
    "未選択": 0, "オス": 1, "メス": 2
  }, _prefix: true

  enum age: {
    "未選択": 0, "子猫": 1, "成猫": 2, "老猫": 3
  }, _prefix: true

  enum type: {
    "未選択": 0, "白": 1, "黒": 2, "グレー": 3, "三毛猫": 4, "茶トラ": 5, "キジトラ": 6, "サバトラ": 7, "サビ": 8, "白黒": 9,
    "グレー白": 10, "茶白": 11, "キジ白": 12, "サバ白": 13, "その他": 14
  }, _prefix: true
  # [type]カラムでエラーが出るのを防ぐために記載
  self.inheritance_column = :_type_disabled

  belongs_to :user
  attachment :image
  has_many :invite_comments, dependent: :destroy
  has_many :marks, dependent: :destroy

  def marked_by?(user, invite)
    marks.where(user_id: user.id, invite_id: invite.id).size > 0
  end
  # mount_uploader :video, VideoUploader
  # mount_uploader :image_id, ImageUploader

  has_many :notifications, dependent: :destroy
  # 気になる通知の処理
  def create_notification_favorite!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and invite_id = ? and action = ? ', current_user.id, user_id, id, 'mark'])
    # blank? = 一度も気になるされていない場合で気になるをされたら通知する
    if temp.blank?
      notification = current_user.active_notifications.new(
        invite_id: id,
        visited_id: user_id,
        action: 'mark'
      )
      # 自分が自分の投稿に気になるをした時は通知済の扱いをする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメント通知の処理
  def create_notification_comment!(current_user, invite_comment_id)
    # （ログイン中の会員と投稿者以外で）同じ投稿にコメントしているユーザーに通知を送る
    temp_ids = InviteComment.where(invite_id: id).where.not('user_id=? or user_id=?', current_user.id, user_id).select(:user_id).distinct
    # 取得したユーザーへの通知レコードを作成
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, invite_comment_id, temp_id['user_id'])
    end
    # 投稿者へ通知を作成
    save_notification_comment!(current_user, invite_comment_id, user_id)
  end

  def save_notification_comment!(current_user, invite_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      invite_id: id,
      invite_comment_id: invite_comment_id,
      visited_id: visited_id,
      action: 'invite_comment'
    )
    # 自分が自分の投稿にコメントした時は通知済の扱いをする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
