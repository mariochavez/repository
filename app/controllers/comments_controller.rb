class CommentsController < ApplicationController
  def create
    publication = Publication.find params[:publication_id]
    comment = Comment.new params[:comment]
    comment.user = current_user
    publication.comments << comment
    publication.save
     
    redirect_to publication
  end
end
