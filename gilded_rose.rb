class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != 'Sulfuras, Hand of Ragnaros'
        item.sell_in -= 1

        case item.name
          when 'Aged Brie'
            aged_brie_action(item)
          when 'Backstage passes to a TAFKAL80ETC concert'
            backstage_action(item)
          when 'Conjured Mana Cake'
            conjured_action(item)
          else
            if item.sell_in < 0
              decreases_twice(item)
            else
              decreases_in_quality(item)
            end
        end
      end
    end
  end

  def increases_in_quality item
    item.quality += 1 if item.quality < 50
  end

  def increases_twice item
    if item.quality < 49
      item.quality += 2
    elsif item.quality == 49
      item.quality += 1
    end
  end

  def increase_three_times item
    if item.quality < 48
      item.quality += 3
    elsif item.quality == 48
      increases_twice(item)
    else
      increases_in_quality(item)
    end
  end

  def decreases_in_quality item
    item.quality -= 1 if item.quality > 0 && item.quality != 80
  end

  def decreases_twice item
    if item.quality > 1 && item.quality != 80
      item.quality -= 2
    elsif item.quality == 1
      item.quality = 0
    end
  end

  def aged_brie_action item
    increases_in_quality item
  end

  def backstage_action item
    if item.sell_in > 5 && item.sell_in <= 10
      increases_twice(item)
    elsif item.sell_in > 0 && item.sell_in <= 5
      increase_three_times(item)
    elsif item.sell_in <= 0
      item.quality = 0
    else
      increases_in_quality(item)
    end
  end

  def conjured_action item
    decreases_twice(item)
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
