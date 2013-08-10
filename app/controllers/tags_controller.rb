class TagsController < ApplicationController
  
  def show
    @tag = Tag.find(params[:id])
    @total_tags = @tag.questions
  end

  def index
    @tag = Tag.all
  end
  
end
