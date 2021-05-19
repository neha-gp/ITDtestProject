class UsersController < ApplicationController

	def index
		@users = User.all
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
      end
  end
  
  def import
    User.import(params[:file])
    redirect_to root_url, notice: "Users Imported"
  end

end



