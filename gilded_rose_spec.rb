require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  let(:expected_items) do
    [
      ['foo,', 1, 2]
    ]
  end

  let(:items) do
    [Item.new('foo', 0, 0)]
  end

  it 'does not change the name' do
    items =
      GildedRose.new(items).update_quality
    expect(items[0].name).to eq 'fixme'
  end
end
