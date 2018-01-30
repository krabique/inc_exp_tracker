# frozen_string_literal: true

class EntriesController < ApplicationController
  before_action :set_entry, only: %i[edit update destroy]
  before_action :current_user_categories, only: %i[new edit create]
  before_action :authorize_action, only: %i[edit update destroy]

  def new
    @entry = current_user.entries.new
  end

  def edit; end

  def create
    @entry = current_user.entries.new(entry_params)

    if @entry.save
      redirect_to root_path, notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  def update
    if @entry.update(entry_params)
      redirect_to root_path, notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if current_user.entries.include?(@entry)
      @entry.destroy
      redirect_to root_path, notice: 'Entry was successfully destroyed.'
    else
      redirect_to root_path, notice: 'That entry does not belong to this user'
    end
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:amount, :comment, :category_id, :date)
  end

  def current_user_categories
    @current_user_categories = current_user.categories
  end

  def authorize_action
    return if @entry.user == current_user

    redirect_back fallback_location: root_path, alert: 'Not authorized!'
  end
end
