class RecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @records = current_user.records.order(created_at: :desc)
  end

  def show
    @record = Record.find(params[:id])
  end

  def new
    @record = Record.new
    @categories = current_user.categories
    @expenditures = current_user.expenditures
  end

  def create
    @record = Record.new(record_params)
    @record.author = current_user

    if @record.save
      redirect_to records_path
    else
      render :new
    end
  end

  def edit
    @record = Record.find(params[:id])
    @categories = current_user.categories
    @expenditures = current_user.expenditures
  end

  def update
    @record = Record.find(params[:id])

    if @record.update(record_params)
      redirect_to records_path
    else
      render :edit
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    redirect_to records_path
  end

  private

  def record_params
    params.require(:record).permit(:category_id, :expenditure_id)
  end

  def require_login
    return if current_user

    redirect_to login_path
  end
end
