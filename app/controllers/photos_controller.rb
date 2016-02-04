class PhotosController < ApplicationController
	before_action :photo_owner, only:[:create]
	before_action :photo_delete, only:[ :edit, :update,:destroy]
	def photo_owner
		@photo=Photo.new
		unless @photo.user_id = current_user.id
			flash[:notice] = "Please log in or register"
			redirect_to root_path
		end
	end
	def photo_delete
		if current_user != Photo.find(params[:id]).user
			redirect_to root_path
		end
		
	end

	def index
		@photos = Photo.all.order(:cached_votes_up => :desc)
		@newphoto = Photo.new
	end
	def new
		@photo=Photo.new
	end
	def create
		@photo = Photo.new(photo_params)
		
		if @photo.save
			flash[:success]="photo added"
			redirect_to photos_path
		else
			render 'new'
		end
	end

	def show
		@photo=Photo.find(params[:id])
	end

	def destroy
		@photo=Photo.find(params[:id])
		@photo.destroy
		# @photo.user = current_user
		flash[:success] = "photo deleted"
		redirect_to photos_path

	end

	def upvote
		@photo=Photo.find(params[:id])
		@photo.liked_by current_user
		redirect_to photos_path
	end

	def downvote
		@photo=Photo.find(params[:id])
		@photo.downvote_by current_user
		redirect_to photos_path
	end
	

	private
	def photo_params
		params.require(:photo).permit(:image, :description)
	end
	
end
