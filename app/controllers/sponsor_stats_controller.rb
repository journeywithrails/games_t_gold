class SponsorStatsController < BaseController
  
  def sent
   @sponsor_ads = SponsoreAd.find(:all, :conditions => ["sponsor_id LIKE ?", current_user.id])  
   @sponsor_teams = SponsorTeam.find(:all, :conditions => ["sponsor_id LIKE ?", current_user.id])  
  end
  
  def accepted
   @sponsor_ads = SponsoreAd.find(:all, :conditions => ["sponsor_id LIKE ? and accept LIKE ?", current_user.id, true])  
   @sponsor_teams = SponsorTeam.find(:all, :conditions => ["sponsor_id LIKE ? and accept LIKE ?", current_user.id, true])  
  end
  
  def denied
   @sponsor_ads = SponsoreAd.find(:all, :conditions => ["sponsor_id LIKE ? and accept LIKE ?", current_user.id, false])  
   @sponsor_teams = SponsorTeam.find(:all, :conditions => ["sponsor_id LIKE ? and accept LIKE ?", current_user.id, false])  
  end
  
end
