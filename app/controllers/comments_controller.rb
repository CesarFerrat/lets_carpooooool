class CommentsController < ApplicationController

  def create
		trip = Trip.find(params[:trip_id])
		@comment = trip.comments.new(comment_params)
		if comment.save
			flash[:notice] = "Success!"
		end
			redirect_to user_trip_path(params[:trip_id])
	end

	def add_comments
		p params
		trip = Trip.find(params[:trip_id])

		comment = trip.comments.new(:title => params[:title],:content => params[:content] )
		p trip
		p comment
		if comment.save
			puts " SAVED"
		end
		render nothing: true
	end

	def send_comments

		trip = Trip.find(params[:id])

		trip.comments.order(created_at: :ASC)

		render(:json => trip.comments)
	end

	private
	def comment_params
		return params.require(:comment).permit(:title, :content)
	end

end
