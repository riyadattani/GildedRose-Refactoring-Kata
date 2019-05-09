# frozen_string_literal: true

require 'gilded_rose'
require 'item'

describe GildedRose do
  describe '#update_quality' do
    describe '#update_quality for normal product' do
      it 'does not change the name' do
        items = [Item.new('foo', 0, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].name).to eq 'foo'
      end

      it 'degrades the quality twice as fast once the sell date has passed' do
        items = [Item.new('foo', 0, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 8
      end

      it 'degrades the quality normally unless the date has passed' do
        items = [Item.new('foo', 10, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 9
      end

      it 'cannot change the quality to less than 0' do
        items = [Item.new('foo', 5, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).not_to eq -1
      end

      it 'never increases the quality to more than 50' do
        items = [Item.new('foo', 0, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).not_to eq 51
      end
    end

    describe '#update_quality for Sulfuras' do
      it 'does not change the quality of a Sulfuras product' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 3, 3)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 3
      end

      it 'does not change the sell in day count of a Sulfuras product' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 3, 3)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 3
      end
    end

    describe '#update_quality for Aged Brie' do
      it 'increases the Quality of Aged Brie twice as much if sell in day is 0' do
        items = [Item.new('Aged Brie', 0, 3)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 5
      end

      it 'increases the Quality of Aged Brie the older it gets' do
        items = [Item.new('Aged Brie', 10, 3)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 4
      end
    end

    describe '#update_quality for Backsatge passes' do
      it 'increases the quality of Backstage passes by 2 if sellIn time is 10 days or less' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 12
      end

      it 'increases the quality of Backstage passes by 3 if sellIn time is 5 days or less' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 4, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 13
      end

      it 'decreases the quality of Backstage passes to 0 if concert is over' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end

      it 'does not increase quality above 50 if started at 49' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 49)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 50
      end
    end

    # it 'decreases the quality of Conjured items twice as fast as normal items' do
    #   items = [Item.new("Conjured", 5, 10)]
    #   GildedRose.new(items).update_quality
    #   expect(items[0].quality).to eq 8
    # end
  end
end
