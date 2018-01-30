# frozen_string_literal: true

Rails.application.routes.draw do
  resources :entries, only: %i[new edit create update destroy]
  resources :categories, only: %i[new edit create update destroy]
  get 'home/index'

  devise_for :users

  root to: 'home#index'
end
