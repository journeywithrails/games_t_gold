class SponsoreAdsController < BaseController
   
  def create 
      
   if request.post?
   @sponsore_ad=SponsoreAd.new(params[:sponsore_ad])
   @sponsore_ad.user_id = params[:id]
   @sponsore_ad.sponsor_id = current_user.id  

   if @sponsore_ad.save
      flash[:notice] = 'Sponsored Ad successfully created'
      redirect_to users_path
   end

   end
  end
  
  def change_status
     @sponsor_ad = SponsoreAd.find(:first, :conditions => ["user_id LIKE ? and sponsor_id LIKE ?",params[:uid],params[:sid]])
     if params[:status]=="1"
       @sponsor_ad.accept=1
     elsif params[:status]=="0"
       @sponsor_ad.accept=0
     end 
     
     if@sponsor_ad.save!
       redirect_to user_path(params[:id])
     end
   end   
end
