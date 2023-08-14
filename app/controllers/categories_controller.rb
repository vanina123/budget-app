class CategoriesController < ApplicationController
    before_action :authenticate_user!
    # before_action :require_login, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
    def index
      @categories = Category.all
    end
  
    def show
      @category = Category.find(params[:id])
    end
  
    def new
      @category = Category.new
  
      if @category.new_record?
      end
    end
  
    def create
        @new_category = current_user.categories.new(category_params)
        if @new_category.save
          flash[:notice] = "#{@new_category.name} created successfully"
          redirect_to categories_path
        else
          flash[:alert] = 'Fill all required fields'
          redirect_to new_category_path
        end
    end
  
    def edit
      @category = Category.find(params[:id])
    end
  
    def update
      @category = Category.find(params[:id])
  
      if @category.update(category_params)
        redirect_to categories_path
      else
        render :edit
      end
    end
  
    def destroy
      @category = Category.find(params[:id])
      @category.destroy
  
      redirect_to categories_path
    end
  
    private
  
    def category_params
        params.required(:category).permit(:name, :icon)
    end
  
    def require_login
      unless current_user
        redirect_to "/users/sign_in"
      end
    end
  end
  