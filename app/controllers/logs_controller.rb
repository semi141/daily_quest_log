class LogsController < ApplicationController

  def new
    @log = Log.new
  end

  def create
    @log = Log.new(log_params)

    if @log.save
      tag_list = params[:log][:tag_names].to_s.split(",")
      save_tags(tag_list)
      redirect_to logs_path
    else
      render :new
    end
  end

  def index
    @logs = Log.all
  end

  def show
    @log = Log.find(params[:id])
  end

  def edit
    @log = Log.find(params[:id])
  end

  def update
    @log = Log.find(params[:id])
    
    if @log.update(log_params)
      tag_list = params[:log][:tag_names].to_s.split(",")
      save_tags(tag_list)
      redirect_to logs_path
    else
      render :edit
    end
  end

  def destroy
    @log = Log.find(params[:id])
    @log.destroy
    redirect_to logs_path
  end

  private

  def log_params
    params.require(:log).permit(
      :title,
      :log_date,
      :duration,
      :design,
      :study,
      :implementation,
      :memo,
      :tag_names
    )
  end

  def save_tags(tag_list)
    tag_list.uniq.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      @log.tags << tag
    end
  end

end
