class RenameFiendshipRequestsToFriendshipRequests < ActiveRecord::Migration[7.0]
  def change
    rename_table :fiendship_requests, :friendship_requests
  end
end
