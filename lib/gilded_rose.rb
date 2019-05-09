# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|

      if !item.name.include?('Aged Brie') && !item.name.include?('Backstage passes to a TAFKAL80ETC concert')
        decrease_quality(item)
      else
        increase_quality(item)
        update_backstage_passes(item)
      end

      decrease_sell_in(item)

      if item.sell_in.negative?
        !item.name.include?('Aged Brie') ? decrease_quality(item) : increase_quality(item)
      end
    end
  end

  private

  def decrease_quality(item)
    if item.quality.positive?
      item.quality -= 1 unless item.name.include?('Sulfuras, Hand of Ragnaros')
      item.quality = 0 if item.name.include?('Backstage passes to a TAFKAL80ETC concert')
    end
  end

  def increase_quality(item)
    item.quality += 1 if item.quality < 50
  end

  def decrease_sell_in(item)
    item.sell_in -= 1 unless item.name.include?('Sulfuras, Hand of Ragnaros')
  end

  def update_backstage_passes(item)
    if item.name.include?('Backstage passes to a TAFKAL80ETC concert')
      increase_quality(item) if item.sell_in < 11
      increase_quality(item) if item.sell_in < 6
    end
  end
end
