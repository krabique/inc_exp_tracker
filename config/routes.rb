# frozen_string_literal: true

Rails.application.routes.draw do
  resources :entries
  resources :categories
  get 'home/index'

  devise_for :users

  root to: 'home#index'
end
