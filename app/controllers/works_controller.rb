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
      redirect_to @work, notice: '作品を保存しました。'
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
        format.html { redirect_to @work, notice: '作品を更新しました。' }
        format.json { render json: { status: 'ok', work: @work }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { status: 'error', errors: @work.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work = current_user.works.find(params[:id])
    @work.destroy
    redirect_to works_path, notice: '作品を削除しました。'
  end

  private

  def work_params
    params.require(:work).permit(:title, :body)
  end
end
