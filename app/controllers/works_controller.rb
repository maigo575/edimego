class WorksController < ApplicationController
  before_action :authenticate_user!

  def index
    @works = current_user.works.order(updated_at: :desc)
  end

  def show
    @work = current_user.works.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = current_user.works.build(work_params)
    if @work.save
      redirect_to @work, notice: "\u4F5C\u54C1\u3092\u4FDD\u5B58\u3057\u307E\u3057\u305F\u3002"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @work = current_user.works.find(params[:id])
  end

  def update
    @work = current_user.works.find(params[:id])
    if @work.update(work_params)
      respond_to do |format|
        format.html { redirect_to @work, notice: "\u4F5C\u54C1\u3092\u66F4\u65B0\u3057\u307E\u3057\u305F\u3002" }
        format.json { render json: { status: "ok", work: @work }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { status: "error", errors: @work.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work = current_user.works.find(params[:id])
    @work.destroy
    redirect_to works_path, notice: "\u4F5C\u54C1\u3092\u524A\u9664\u3057\u307E\u3057\u305F\u3002"
  end

  private

  def work_params
    params.require(:work).permit(:title, :body)
  end
end
