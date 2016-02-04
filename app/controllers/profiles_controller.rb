class ProfilesController < ApplicationController
	def show
		@profile=Profile.find(params[:id])
	end
	def new
		@profile=Profile.new
	end
	def create
		@profile=Profile.new(profile_params)
		@profile.user=current_user

		if @profile.save
			redirect_to profile_path(@profile)
			flash[:notice] = "created profile"
		else
			flash[:alert] = "could not save profile #{@profile.errors.full_messages.join(';')}"
			redirect_to new_profile_path
		end
	end

	def edit
		@profile=Profile.find(params[:id])
	end

	def update
		@profile=Profile.find(params[:id])
		@profile.user = current_user

		if @profile.update_attributes(profile_params)
			redirect_to profile_path(@profile)
		else
			render 'edit'
		end
	end

	def destroy
		@profile=Profile.find(params[:id]).destroy
		redirect_to photos_path
	end

	private
	def profile_params
		params.require(:profile).permit(:tagline,:avatar)
	end
end
