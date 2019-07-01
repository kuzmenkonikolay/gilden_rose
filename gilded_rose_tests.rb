require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase
  def setup
    @items = [
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

  test 'normal items' do
    days = 2
    gilded_rose = GildedRose.new(@items)
    (0...days).each do |day|
      gilded_rose.update_quality
    end

    assert_equal @items[0].quality, 18
    assert_equal @items[2].quality, 5
  end

  test 'normal_items_zero_case' do
    days = 25
    gilded_rose = GildedRose.new(@items)
    (0...days).each do |day|
      gilded_rose.update_quality
    end

    assert_equal @items[0].quality, 0
    assert_equal @items[2].quality, 0
  end

  test 'aged_brie' do
    days = 3
    gilded_rose = GildedRose.new(@items)
    (0...days).each do |day|
      gilded_rose.update_quality
    end

    assert_equal @items[1].quality, 3
  end

  test 'aged_brie_max_case' do
    days = 100
    gilded_rose = GildedRose.new(@items)
    (0...days).each do |day|
      gilded_rose.update_quality
    end

    assert_equal @items[1].quality, 50
  end

  test 'sulfuras_case' do
    days = 100
    gilded_rose = GildedRose.new(@items)
    (0...days).each do |day|
      gilded_rose.update_quality
    end

    assert_equal @items[3].quality, 80
    assert_equal @items[4].quality, 80
  end

  test 'backstage_case' do
    days = 5
    gilded_rose = GildedRose.new(@items)
    (0...days).each do |day|
      gilded_rose.update_quality
    end

    assert_equal @items[5].quality, 26
    assert_equal @items[6].quality, 50
    assert_equal @items[7].quality, 0
  end

  test 'conjured_case' do
    days = 2
    gilded_rose = GildedRose.new(@items)
    (0...days).each do |day|
      gilded_rose.update_quality
    end

    assert_equal @items[8].quality, 2
  end
end
