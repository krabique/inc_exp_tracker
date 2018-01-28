require 'rails_helper'

RSpec.describe 'entries/new', type: :view do
  before(:each) do
    assign(:entry, Entry.new(
                     amount: '',
                     comment: 'MyText',
                     user: nil,
                     category: nil
    ))
  end

  it 'renders new entry form' do
    render

    assert_select 'form[action=?][method=?]', entries_path, 'post' do
      assert_select 'input[name=?]', 'entry[amount]'

      assert_select 'textarea[name=?]', 'entry[comment]'

      assert_select 'input[name=?]', 'entry[user_id]'

      assert_select 'input[name=?]', 'entry[category_id]'
    end
  end
end
