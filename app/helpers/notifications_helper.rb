module NotificationsHelper
  def notification_form(notification)
    # 通知を送ってきたユーザーを取得
    visitor = notification.visitor
    # コメントの内容を通知に表示する
    @comment = nil
    visitor_i_comment = notification.invite_comment_id
    visitor_p_comment = notification.post_comment_id
    # notification.actionの内容で処理を変える
    case notification.action
    # 募集に対する気になる
    when 'mark'
      tag.a(notification.visitor.handle_name, href: user_path(visitor)) + 'さんが' + tag.a("募集「#{notification.invite.title}」", href: invite_path(notification.invite_id)) + 'を気にしています。'
    # 募集に対するコメント
    when 'invite_comment' then
      @comment = InviteComment.find_by(id: visitor_i_comment)
      # @comment_comment = @comment.comment
      # invite_title = @comment.invite.title
      tag.a(visitor.handle_name, href: user_path(visitor)) + 'さんが' + tag.a("募集「#{notification.invite.title}」", href: invite_path(notification.invite_id)) + 'にコメントしました。'
    # 投稿に対するいいね
    when 'favorite'
      tag.a(notification.visitor.handle_name, href: user_path(visitor)) + 'さんが' + tag.a("投稿「#{notification.post.title}」", href: post_path(notification.post_id)) + 'にいいねしました。'
    # 投稿に対するコメント
    when 'post_comment' then
      @comment = PostComment.find_by(id: visitor_p_comment)
      # @comment_comment = @comment.comment
      # post_title = @comment.post.title
      tag.a(visitor.handle_name, href: user_path(visitor)) + 'さんが' + tag.a("投稿「#{notification.post.title}」", href: post_path(notification.post_id)) + 'にコメントしました。'
    end
  end

  # 未確認の通知があるか確認する(ナビゲーションバーで使用)
  def unchecked_notifications
    notifications = current_user.passive_notifications.where(checked: false)
  end
end
