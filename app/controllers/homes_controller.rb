class HomesController < ApplicationController
  def top
    @invites = Invite.order(created_at: :desc).limit(4)
  end

  def about; end
end
