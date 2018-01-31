# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  describe 'GET #index' do
    context 'without using the entries filter' do
      let(:category) { create(:category, user: user) }
      let(:entry) { create(:entry, user: user, category: category) }

      it 'returns a success response' do
        get :index
        expect(response).to be_success
      end

      it "assigns the current user's categories to the @categories" do
        get :index
        expect(assigns(:categories)).to eq user.categories
      end

      it "assigns all current user's entries to @entries" do
        get :index
        expect(assigns(:entries)).to eq user.entries
      end
    end

    context 'when using the entries filter' do
      let!(:other_user) { create(:user) }

      let!(:my_category_one) { create(:category, user: user) }
      let!(:my_category_two) { create(:category, user: user) }

      let!(:date_one) { Time.zone.parse(2.years.ago.to_s) }
      let!(:date_two) { Time.zone.parse(1.day.ago.to_s) }

      let!(:my_entry_one_from_category_one) {
        create(:entry, user: user, category: my_category_one, date: date_one)
      }
      let!(:my_entry_two_from_category_one) {
        create(:entry, user: user, category: my_category_one, date: date_two)
      }
      let!(:my_entry_three_from_category_two) {
        create(:entry, user: user, category: my_category_two, date: date_one)
      }

      let!(:others_category) { create(:category, user: other_user) }
      let!(:others_entry) {
        create(:entry, user: other_user, category: others_category)
      }

      context 'with valid values' do
        context 'assigns the @entries to ' \
                "current user's entries ordered descending and filtered by " \
                'the specified' do

          it 'category' do
            get :index, params: {
              category: { name: my_category_one.name }
            }

            expect(assigns(:entries)).to eq user.entries.joins(:category)
              .where(categories: { name: my_category_one.name })
                                                .order('date DESC')
          end

          it 'start date' do
            get :index, params: {
              start_date: date_two
            }

            expect(assigns(:entries)).to eq user.entries.joins(:category)
              .where(date: date_two..Time.zone.now)
                                                .order('date DESC')
          end

          it 'end date' do
            get :index, params: {
              end_date: date_one
            }

            expect(assigns(:entries)).to eq user.entries.joins(:category)
              .where(date: Time.new(0)..date_one)
                                                .order('date DESC')
          end

          it 'start date and end date' do
            start_date = date_one - 1.day
            end_date = date_one + 1.day

            get :index, params: {
              start_date: start_date, end_date: end_date
            }

            expect(assigns(:entries)).to eq user.entries.joins(:category)
              .where(date: start_date..end_date)
                                                .order('date DESC')
          end

          it 'category and start date' do
            get :index, params: {
              category: { name: my_category_one.name },
              start_date: date_two
            }

            expect(assigns(:entries)).to eq user.entries.joins(:category)
              .where(categories: { name: my_category_one.name })
              .where(date: date_two..Time.zone.now).order('date DESC')
          end

          it 'category and end date' do
            get :index, params: {
              category: { name: my_category_one.name },
              end_date: date_one
            }

            expect(assigns(:entries)).to eq user.entries.joins(:category)
              .where(categories: { name: my_category_one.name })
              .where(date: Time.new(0)..date_one).order('date DESC')
          end

          it 'category, start date and end date' do
            start_date = date_one - 1.day
            end_date = date_one + 1.day

            get :index, params: {
              category: { name: my_category_one.name },
              start_date: start_date,
              end_date: end_date
            }

            expect(assigns(:entries)).to eq user.entries.joins(:category)
              .where(categories: { name: my_category_one.name })
              .where(date: start_date..end_date).order('date DESC')
          end
        end
      end

      context 'with invalid date' do
        let(:back) { 'http://google.com' }
        before { request.env['HTTP_REFERER'] = back }

        it 'redirects back' do
          start_date = 'abc'
          end_date = 'def'

          get :index, params: {
            start_date: start_date, end_date: end_date
          }
          expect(response).to redirect_to(back)
        end

        it 'shows alert' do
          start_date = 'abc'
          end_date = 'def'

          get :index, params: {
            start_date: start_date, end_date: end_date
          }
          expect(flash[:alert]).to eq 'Invalid date'
        end
      end
    end
  end
end
