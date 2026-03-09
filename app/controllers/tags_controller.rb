class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @logs = @tag.logs.order(log_date: :desc)
  end
end
