class BuddyshipsController < ApplicationController

  # POST /buddyships
  # POST /buddyships.json
  def create
    @buddyship = current_user.buddyships.build(buddy_id: params[:buddy_id])
    user = User.find_by_id(params[:buddy_id])
    user.current_buddy = current_user.id
    current_user.current_buddy = user.id
    user.status = "Buddied-Up"
    current_user.status = "Buddied-Up"
    user.save
    current_user.save

    respond_to do |format|
      if @buddyship.save
        format.html { redirect_to current_user.buddies.last, notice: 'Buddied' }
        format.json { render :show, status: :created, location: current_user }
      else
        format.html { redirect_to current_user, error: 'Could not buddy-up' }
        format.json { render json: @buddyship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buddyships/1
  # DELETE /buddyships/1.json
  def destroy
    user = User.find_by_id(params[:buddy_id])
    user.current_buddy = nil
    current_user.current_buddy = nil
    if current_user.buddies.blank?
      current_user.status = "Buddy-less"
    end
    user.save
    current_user.save

    @buddyship = current_user.buddyships.where("buddy_id = ? and user_id = ?", params[:buddy_id], current_user.id).first
    @buddyship.destroy
    respond_to do |format|
      format.html { redirect_to user, notice: 'De-Buddified' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def buddyship_params
      params.require(:buddyship).permit(:user_id, :buddy_id, :create, :destroy)
    end
end
