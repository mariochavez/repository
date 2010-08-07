class CommentsController < ApplicationController
  before_filter do
    @publication = Publication.find params[:publication_id]
  end
  
  def create
    comment = Comment.new params[:comment]
    comment.user = current_user
    @publication.comments << comment
    
    if @publication.save
      redirect_to @publication, :notice => 'Comment was successfully created.'
    else
      redirect_to @publication, :notice => 'Comment body is missing, comment was not created.'
    end
  end
  
  def destroy
    comment = Comment.find params[:id]
    
    if current_user == @publication.user || current_user == comment.user
      comment.destroy
      redirect_to @publication, :notice => 'Comment was successfully deleted.'
    else
      redirect_to @publication, :notice => 'You are not allowed to deleted the comment.'
    end
  end
    
end
