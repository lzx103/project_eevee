class Photo < ActiveRecord::Base
	belongs_to :user

	acts_as_votable

	def score
		self.get_upvotes.size - self.get_downvotes.size
	end

	# @photo = Photo.new(:name => 'my upload!')
	# @photo.save

	# @photo.liked_by @user
	# @photo.votes_for.size => 1

	has_attached_file :image, :styles =>
	{ 
		:medium => "300x300>", 
		:thumb => "100x100>",
		:original => "500x500>" 
	},
	:default_url => "/images/:style/missing.png",
	url: "/system/:class/:attachment/:id_partition/:style/:hash.:extension",
 	hash_secret: "RqDVV+1QDIhoYFn6y3M/08YnkGuqjtCL1oObaZ0AC+E4VmHGUHZhFNoC1Bc2ovfwocmU7dYeUzKIw/caKzXm52m72bHeXm+Tly0CfjO5lbSUGfYVdoj2kpJfRx6Aiif/Hs9o+6wbwsWYzfkhdNNvU4s543961SKWEzlfcjCIFhU="


    validates_attachment :image, presence: true,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                     size: { in: 0..500.kilobytes }
end
