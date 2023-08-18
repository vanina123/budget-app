class ExpendituresController < ApplicationController
  before_action :authenticate_user!

  def index
    @category = Category.find(params[:category_id])
    @expenditures = @category.expenditures
    @total_amount = @expenditures.sum(:amount)
  end

  def show
    @expenditure = Expenditure.find(params[:id])
  end

  def new
    @expenditure = Expenditure.new
    @selected_category = Category.find(params[:category_id])
    @categories = Category.where(author_id: current_user.id).includes([:author]).order(created_at: :desc)
  end

  def create
    @expenditure = Expenditure.new(expenditure_params)
    @expenditure.author = current_user

    if @expenditure.save
      params[:category_ids].each do |id|
        Record.create(category_id: id.to_i, expenditure_id: @expenditure.id)
      end
      redirect_to category_expenditures_path(params[:category_id]), notice: 'expenditure created'
    else
      render :new, status: 422
    end
  end

  def edit
    @expenditure = Expenditure.find(params[:id])
    @categories = current_user.categories
  end

  def update
    @expenditure = Expenditure.find(params[:id])

    if @expenditure.update(expenditure_params)
      @expenditure.categories = params[:expenditure][:categories]
      redirect_to expenditures_path
    else
      render :edit
    end
  end

  def destroy
    @expenditure = Expenditure.find(params[:id])
    @expenditure.destroy

    redirect_to expenditures_path
  end

  private

  def expenditure_params
    params.require(:expenditure).permit(:name, :amount)
  end

  def require_login
    return if current_user

    redirect_to login_path
  end
end
