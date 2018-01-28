require 'rails_helper'

RSpec.describe 'entries/edit', type: :view do
  before(:each) do
    @entry = assign(:entry, Entry.create!(
                              amount: '',
                              comment: 'MyText',
                              user: nil,
                              category: nil
    ))
  end

  it 'renders the edit entry form' do
    render

    assert_select 'form[action=?][method=?]', entry_path(@entry), 'post' do
      assert_select 'input[name=?]', 'entry[amount]'

      assert_select 'textarea[name=?]', 'entry[comment]'

      assert_select 'input[name=?]', 'entry[user_id]'

      assert_select 'input[name=?]', 'entry[category_id]'
    end
  end
end
