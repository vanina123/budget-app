class ExpendituresController < ApplicationController
    before_action :authenticate_user!

    # before_action :require_login, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
    def index
      @expenditures = current_user.expenditures.order(created_at: :desc)
    end
  
    def show
      @expenditure = Expenditure.find(params[:id])
    end
  
    def new
      @expenditure = Expenditure.new
      @categories = current_user.categories
    end
  
    def create
      @expenditure = Expenditure.new(expenditure_params)
      @expenditure.author = current_user
  
      if @expenditure.save
        @expenditure.categories << params[:expenditure][:categories]
        redirect_to expenditures_path
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
      params.require(:expenditure).permit(:name, :amount, :categories)
    end
  
    def require_login
      unless current_user
        redirect_to login_path
      end
    end
  end
  