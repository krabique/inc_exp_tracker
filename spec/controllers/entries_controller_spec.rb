# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }

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
    let(:entry) { create(:entry, user: user, category: category) }

    it 'renders the :edit template' do
      # byebug
      get :edit, params: { id: entry.id }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new entry in the database' do
        expect do
          post :create, params: {
            entry: attributes_for(:entry, category_id: category.id)
          }
        end.to change(Entry, :count).by(1)
      end

      it 'redirects to the home page' do
        post :create, params: {
          entry: attributes_for(:entry, category_id: category.id)
        }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new entry in the database' do
        expect do
          post :create, params: { entry: attributes_for(:invalid_entry) }
        end.to_not change(Entry, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { entry: attributes_for(:invalid_entry) }
        expect(response).to render_template :new
      end
    end

    context 'when trying to create a entry for another user' do
      let(:another_user) { create(:user) }

      it 'does not save the new entry in the database' do
        post :create, params: { entry: attributes_for(
          :entry, user_id: another_user.id, category_id: category.id
        ) }
        expect(Entry.last.user).to_not eq another_user
      end

      it 'redirects to the home page' do
        post :create, params: { entry: attributes_for(
          :entry, user_id: another_user.id, category_id: category.id
        ) }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PUT #update' do
    let(:entry) { create(:entry, user: user, category: category) }

    context 'with valid attributes' do
      it "changes the entry's comment and saves it to the database" do
        comment = Faker::WorldOfWarcraft.hero

        put :update, params: { id: entry.id, entry: { comment: comment } }

        assigns(:entry).reload

        expect(assigns(:entry).comment).to eq comment
      end

      it 'redirects to the home page' do
        comment = Faker::WorldOfWarcraft.hero
        put :update, params: { id: entry.id, entry: { comment: comment } }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      context 'for comment' do
        it 'does not update the entry' do
          initial_comment = entry.comment

          put :update, params: { id: entry.id, entry: { amount: 'abc' } }

          assigns(:entry).reload

          expect(assigns(:entry).comment).to eq initial_comment
        end

        it 're-renders the :edit template' do
          put :update, params: { id: entry.id, entry: { amount: 'abc' } }

          expect(response).to render_template :edit
        end
      end
    end

    context "when user is trying to update someone else's entry" do
      it 'should not update the entry' do
        other_user = create(:user)
        other_user_category = create(:category, user: other_user)
        other_user_entry = create(:entry, user: other_user,
                                          category: other_user_category)

        initial_comment = other_user_entry.comment

        put :update, params: {
          id: other_user_entry.id,
          entry: { comment: initial_comment.to_f + 1 }
        }

        assigns(:entry).reload

        expect(assigns(:entry).comment).to eq initial_comment
      end
    end
  end

  describe 'DELETE #destroy' do
    context "with user's own entries" do
      let!(:entry) { create(:entry, user: user, category: category) }

      it 'destroys the entry' do
        expect do
          delete :destroy, params: { id: entry.id }
        end.to change(Entry, :count).by(-1)
      end
    end

    context "with other users' entries" do
      let!(:user) { create(:user) }
      let(:another_user) { create(:user) }
      let(:another_category) { create(:category, user: another_user) }
      let!(:others_entry) {
        create(:entry, user: another_user, category: another_category)
      }

      it 'does not destroy the entry' do
        expect do
          delete :destroy, params: { id: others_entry.id }
        end.to_not change(Entry, :count)
      end

      it 'redirects to the home page' do
        delete :destroy, params: { id: others_entry.id }
        expect(response).to redirect_to root_path
      end
    end
  end
end
