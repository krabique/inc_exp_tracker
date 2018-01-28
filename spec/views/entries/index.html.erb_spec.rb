require 'rails_helper'

RSpec.describe 'entries/index', type: :view do
  before(:each) do
    assign(:entries, [
             Entry.create!(
               amount: '',
               comment: 'MyText',
               user: nil,
               category: nil
             ),
             Entry.create!(
               amount: '',
               comment: 'MyText',
               user: nil,
               category: nil
             )
           ])
  end

  it 'renders a list of entries' do
    render
    assert_select 'tr>td', text: ''.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
