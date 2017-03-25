class ScansController < ApplicationController

  def index
    @scans = Scan.all
  end

  def show
    @scan = Scan.find(params[:id])
    @result = redis.get(@scan.id)
  end


  def new
    @scan ||= Scan.new
  end


  def create
    @scan = Scan.new(scan_params)

    if @scan.save
      Hellraiserasync.perform_async(@scan.id)
      redirect_to @scan
    else
      render 'new'
    end
  end

  def update
    @scan = Scan.find(params[:id])

    if @scan.update(scan_params)
      redirect_to @scan
    else
      render 'edit'
    end
  end

  def destroy
    @scan = Scan.find(params[:id])
    FileUtils.rm Dir.glob(HellRaiser.configuration.output_dir + @scan.id.to_s + '.*')
    redis.del @scan.id
    @scan.destroy
    redirect_to scans_path
  end

private
  def scan_params
    params.require(:scan).permit(:title, :target)
  end

  def redis
    @redis ||= Redis.new
  end

end
