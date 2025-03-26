class GildedRose
  ITEM_SELL_IN_WAY_ONE = 10
  ITEM_SELL_IN_WAY_TWO = 5
  ITEM_QUALITY_MID = 50

  ITEM_HANDLERS = {
    'Aged Brie' => :aged_handler,
    'Backstage passes to a TAFKAL80ETC concert' => :backstage_handler
  }.freeze

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if item.name == 'Sulfuras, Hand of Ragnaros'

      method_name = ITEM_HANDLERS[item.name] || :other_handler
      send(method_name, item)
    end
  end

  private

  def aged_handler(item)
    increase_quality(item)
    change_sell_in(item)
    increase_quality(item) if item.sell_in.negative?
  end

  def backstage_handler(item)
    increase_quality(item)
    increase_quality(item) if item.sell_in <= ITEM_SELL_IN_WAY_ONE
    increase_quality(item) if item.sell_in <= ITEM_SELL_IN_WAY_TWO
    change_sell_in(item)
    item.quality = 0 if item.sell_in.negative?
  end

  def other_handler(item)
    decrease_quality(item)
    change_sell_in(item)
    decrease_quality(item) if item.sell_in.negative?
  end

  def change_sell_in(item)
    item.sell_in -= 1
  end

  def increase_quality(item)
    item.quality += 1 if item.quality < ITEM_QUALITY_MID
  end

  def decrease_quality(item)
    item.quality -= 1 if item.quality.positive?
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
