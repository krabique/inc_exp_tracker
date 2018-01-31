# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    let(:category) { create(:category, user: user) }

    it 'renders the :edit template' do
      get :edit, params: { id: category.id }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new category in the database' do
        expect do
          post :create, params: { category: attributes_for(:category) }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the home page' do
        post :create, params: { category: attributes_for(:category) }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new category in the database' do
        expect do
          post :create, params: { category: attributes_for(:invalid_category) }
        end.to_not change(Category, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { category: attributes_for(:invalid_category) }
        expect(response).to render_template :new
      end
    end

    context 'when trying to create a category for another user' do
      let(:another_user) { create(:user) }

      it 'does not save the new category in the database' do
        post :create, params: { category: attributes_for(
          :category, user_id: another_user.id
        ) }
        expect(Category.last.user).to eq user
      end
    end
  end

  describe 'PUT #update' do
    let(:category) { create(:category, user: user) }

    context 'with valid attributes' do
      it "changes the category's name and saves it to the database" do
        name = Faker::WorldOfWarcraft.hero

        put :update, params: { id: category.id, category: { name: name } }

        assigns(:category).reload

        expect(assigns(:category).name).to eq name
      end

      it 'redirects to the home page' do
        name = Faker::WorldOfWarcraft.hero
        put :update, params: { id: category.id, category: { name: name } }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      context 'for name' do
        it 'does not update the category' do
          initial_name = category.name

          put :update, params: { id: category.id, category: { group: 'abc' } }

          assigns(:category).reload

          expect(assigns(:category).name).to eq initial_name
        end

        it 're-renders the :new template' do
          put :update, params: { id: category.id, category: { group: 'abc' } }

          expect(response).to render_template :edit
        end
      end
    end

    context "when user is trying to update someone else's category" do
      it 'should not update the category' do
        other_user_category = create(:category, user: create(:user))

        initial_name = other_user_category.name

        put :update, params: {
          id: other_user_category.id,
          category: { name: initial_name.to_f + 1 }
        }

        assigns(:category).reload

        expect(assigns(:category).name).to eq initial_name
      end
    end
  end

  describe 'PUT #update' do
    context "with user's own categories" do
      let!(:category) { create(:category, user: user) }

      it 'destroys the category' do
        expect do
          delete :destroy, params: { id: category.id }
        end.to change(Category, :count).by(-1)
      end
    end

    context "with other users' categories" do
      let(:another_user) { create(:user) }
      let!(:category) { create(:category, user: another_user) }

      it 'does not destroy the category' do
        expect do
          delete :destroy, params: { id: category.id }
        end.to_not change(Category, :count)
      end
    end
  end
end
