class ScansController < ApplicationController

  def index
    respond_to do |format|
      format.json { render json: ScansDatatable.new(view_context) }
      format.html
    end
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
      @scan.update(jid: HellraiserWorker.perform_async(@scan.id))
    else
      render 'new'
    end

    respond_to :js
  end

  def update
    @scan = Scan.find(params[:id])
    @scan.queued!
    @scan.update(jid: HellraiserWorker.perform_async(@scan.id))
    respond_to :js
  end

  def destroy
    @scan = Scan.find(params[:id])

    if @scan.finished?
      FileUtils.rm Dir.glob(HellRaiser.configuration.output_dir + @scan.id.to_s + '.*')
      redis.del @scan.id
      @scan.destroy
    else
      HellraiserWorker.cancel!(@scan.jid)
      @scan.finished!
    end

    respond_to :js
  end

  private

  def scan_params
    params.require(:scan).permit(:title, :target)
  end

  def redis
    @redis ||= Redis.new
  end

end
