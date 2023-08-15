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
      @category = Category.find(params[:category_id])
      @expenditure = Expenditure.new
      @categories = Category.all
    end

    def create
      @category = Category.find(params[:category_id])
      @expenditure = Expenditure.new(expenditure_params)
      @expenditure.author = current_user
  
      if @expenditure.save
        Record.create(category_id:params[:category_id],expenditure_id:@expenditure.id)
          redirect_to category_expenditures_path(@category), notice: 'expenditure created'
      else
          render :new
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
      params.require(:expenditure).permit(:name, :amount, :category_ids)
    end
  
    def require_login
      unless current_user
        redirect_to login_path
      end
    end
  end
  