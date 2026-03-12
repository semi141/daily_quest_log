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
    if params[:keyword].present?
      @logs = Log.where(
        "title LIKE :keyword OR design LIKE :keyword OR study LIKE :keyword OR implementation LIKE :keyword",
        keyword: "%#{params[:keyword]}%"
      ).order(log_date: :desc)
    else
      @logs = Log.order(log_date: :desc)
    end

    @total_minutes = Log.sum(:duration)
    @today_minutes = Log.where(log_date: Date.current).sum(:duration)
    @week_minutes = Log.where(log_date: Date.current.beginning_of_week..Date.current.end_of_week).sum(:duration)
    @month_minutes = Log.where(log_date: Date.current.beginning_of_month..Date.current.end_of_month).sum(:duration)

    @total_xp = Log.sum(:duration)

    level = 1

    exp = @total_xp

    while exp >= (100 + level * 20)
      exp -= (100 + level * 20)
      level += 1
    end

    @level = level
    @current_exp = exp

    @next_level_xp = 100 + level * 20
    @remaining_xp = @next_level_xp - exp
    @exp_percentage = (@current_exp.to_f / @next_level_xp) * 100
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
