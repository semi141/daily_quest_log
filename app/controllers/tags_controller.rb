class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @logs = @tag.logs
  end
end
