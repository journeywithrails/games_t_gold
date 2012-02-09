ActionController::Routing::Routes.draw do |map|
  map.resources :users do |user|
    user.resources :photo_albums, :shallow => true do |photo_album|
      photo_album.resources :photos
    end

    user.resources :teams
    user.resources :tournaments, :as => 'ladders' do |tournament|
      tournament.resources :matches, :member => { :edit_winner => :get, :update_winner => :put, :forfeit => :put }
    end
  end

  map.resources :teams, :member => { :dissolve => :get } do |team|
    team.resources :memberships, :member => { :promote => :put, :demote => :put, :revoke => :get, :terminate => :get }
    team.resources :requests, :controller => 'MembershipRequests', :member => { :accept => :post }
    team.resources :invitations, :controller => 'MembershipInvitations', :collection => { :auto_complete_for_membership_invitation_to => :get },
      :member => { :accept => :post }
  end

  map.resources :tournaments, :as => 'ladders', :member => { :tag => :get } do |tournament|
    tournament.resources :matches
  end

  map.resources :terms, :controller => 'Terms', :action => 'index'
  
  map.from_plugin :community_engine

  map.resources :players, :controller => 'UserProfiles'
  map.resources :sponsors, :controller => 'SponsorProfiles' 

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
 
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
