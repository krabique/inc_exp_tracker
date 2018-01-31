# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @entries = filter_entries
    @categories = current_user.categories
  end

  private

  def filter_entries
    if params[:category] && !params[:category][:name].blank? &&
       (!params[:start_date].blank? || !params[:end_date].blank?)
      entry_query.where(category_query_condition).where(date_query_condition)
    elsif params[:category] && !params[:category][:name].blank?
      entry_query.where(category_query_condition)
    elsif !params[:start_date].blank? || !params[:end_date].blank?
      entry_query.where(date_query_condition)
    else
      current_user.entries.includes(:category).order('date DESC')
                  .page(params[:page]).per(5)
    end
  end

  def entry_query
    current_user.entries.joins(:category).order('date DESC')
                .page(params[:page]).per(5)
  end

  def start_date
    params[:start_date].blank? ? Time.new(0).to_s : params[:start_date]
  end

  def end_date
    params[:end_date].blank? ? Time.zone.now.to_s : params[:end_date]
  end

  def category_query_condition
    ['categories.name = ?', params[:category][:name]]
  end

  def date_query_condition
    parsed_start_date = Time.zone.parse(start_date)
    parsed_end_date = Time.zone.parse(end_date)

    redirect_back(alert: 'Invalid date', fallback_location: root_path) if
      parsed_start_date.nil? || parsed_end_date.nil?

    { date: parsed_start_date..parsed_end_date }
  end
end
