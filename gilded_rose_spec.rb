# frozen_string_literal: true

require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  let(:items) do
    [
      Item.new('+5 Dexterity Vest', 10, 20),
      Item.new('Aged Brie', 2, 0),
      Item.new('Elixir of the Mongoose', 5, 7),
      Item.new('Sulfuras, Hand of Ragnaros', 0, 80),
      Item.new('Sulfuras, Hand of Ragnaros', -1, 80),
      Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20),
      Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 49),
      Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 49),
      Item.new('Conjured Mana Cake', 3, 6)
    ]
  end

  shared_examples 'correct attributes' do
    let(:expected_names) { expected_items.map { |item| item[:name] } }
    let(:expected_sell_in) { expected_items.map { |item| item[:sell_in] } }
    let(:expected_quality) { expected_items.map { |item| item[:quality] } }

    it 'does not change the name' do
      gilded_rose_items.each_with_index { |item, i| expect(item.name).to eq expected_names[i] }
    end

    it 'has correct sell_in' do
      gilded_rose_items.each_with_index { |item, i| expect(item.sell_in).to eq expected_sell_in[i] }
    end

    it 'has correct quality' do
      gilded_rose_items.each_with_index { |item, i| expect(item.quality).to eq expected_quality[i] }
    end
  end

  context 'after 1 day' do
    it_behaves_like 'correct attributes' do
      let(:expected_items) do
        [
          { "name": '+5 Dexterity Vest', "sell_in": 9, "quality": 19 },
          { "name": 'Aged Brie', "sell_in": 1, "quality": 1 },
          { "name": 'Elixir of the Mongoose', "sell_in": 4, "quality": 6 },
          { "name": 'Sulfuras, Hand of Ragnaros', "sell_in": 0, "quality": 80 },
          { "name": 'Sulfuras, Hand of Ragnaros', "sell_in": -1, "quality": 80 },
          { "name": 'Backstage passes to a TAFKAL80ETC concert', "sell_in": 14, "quality": 21 },
          { "name": 'Backstage passes to a TAFKAL80ETC concert', "sell_in": 9, "quality": 50 },
          { "name": 'Backstage passes to a TAFKAL80ETC concert', "sell_in": 4, "quality": 50 },
          { "name": 'Conjured Mana Cake', "sell_in": 2, "quality": 5 }
        ]
      end

      let(:gilded_rose_items) do
        gr = GildedRose.new(items)
        gr.update_quality
        gr.items
      end
    end
  end

  context 'after 10 days' do
    it_behaves_like 'correct attributes' do
      let(:expected_items) do
        [
          { name: '+5 Dexterity Vest', sell_in: 0, quality: 10 },
          { name: 'Aged Brie', sell_in: -8, quality: 18 },
          { name: 'Elixir of the Mongoose', sell_in: -5, quality: 0 },
          { name: 'Sulfuras, Hand of Ragnaros', sell_in: 0, quality: 80 },
          { name: 'Sulfuras, Hand of Ragnaros', sell_in: -1, quality: 80 },
          { name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: 5, quality: 35 },
          { name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: 0, quality: 50 },
          { name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: -5, quality: 0 },
          { name: 'Conjured Mana Cake', sell_in: -7, quality: 0 }
        ]
      end

      let(:gilded_rose_items) do
        gr = GildedRose.new(items)
        10.times { gr.update_quality }
        gr.items
      end
    end
  end

  context 'after 100 days' do
    it_behaves_like 'correct attributes' do
      let(:expected_items) do
        [
          { "name": '+5 Dexterity Vest', "sell_in": -90, "quality": 0 },
          { "name": 'Aged Brie', "sell_in": -98, "quality": 50 },
          { "name": 'Elixir of the Mongoose', "sell_in": -95, "quality": 0 },
          { "name": 'Sulfuras, Hand of Ragnaros', "sell_in": 0, "quality": 80 },
          { "name": 'Sulfuras, Hand of Ragnaros', "sell_in": -1, "quality": 80 },
          { "name": 'Backstage passes to a TAFKAL80ETC concert', "sell_in": -85, "quality": 0 },
          { "name": 'Backstage passes to a TAFKAL80ETC concert', "sell_in": -90, "quality": 0 },
          { "name": 'Backstage passes to a TAFKAL80ETC concert', "sell_in": -95, "quality": 0 },
          { "name": 'Conjured Mana Cake', "sell_in": -97, "quality": 0 }
        ]
      end

      let(:gilded_rose_items) do
        gr = GildedRose.new(items)
        100.times { gr.update_quality }
        gr.items
      end
    end
  end
end
