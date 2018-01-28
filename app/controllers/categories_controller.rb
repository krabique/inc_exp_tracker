# frozen_string_literal: true

class CategoriesController < ApplicationController
  include CategoriesHelpers

  before_action :set_category, only: %i[show edit update destroy]
  before_action :category_group_options, only: %i[new edit create update]
  before_action :authorize_action, only: %i[edit update destroy]

  def index
    @categories = current_user.categories
  end

  def new
    @category = current_user.categories.new
  end

  def edit; end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to root_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to root_path, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if current_user.categories.include?(@category)
      @category.destroy
      redirect_to root_path, notice: 'Category was successfully destroyed.'
    else
      redirect_to root_path,
                  notice: 'That category does not belong to this user'
    end
  end

  private

  def authorize_action
    return if @category.user == current_user

    redirect_back fallback_location: root_path, alert: 'Not authorized!'
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :group)
  end
end
