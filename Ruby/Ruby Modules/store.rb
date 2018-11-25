module Inventoryable

  def self.included(klass)
    klass.extend(ClassMethods)
    klass.extend(Enumerable) #Enumarable needs .each method called to &block
  end

  module ClassMethods
    def create(attributes)
      object = new(attributes)
      instances.push(object)
      return object
    end

    def instances
      @instances ||= [] #creates conditional t only create empty array if none available
    end

    def each(&block)
      instances.each(&block)
    end

    def report (title, items)
      puts "-" * 50
      puts title
      puts "-" * 50
      items.each do |item|
        line = []
        line.push("Item: #{item.attributes[:name]}")
        line.push("Stock: #{item.stock_count}")
        if item.attributes.include?(:size)
          line.push("Size: #{item.attributes[:size]}")
        end
        puts line.join("\t")
      end
      puts "\n"
    end

    def in_stock_report
      title = "#{self.to_s} In Stock Report"
      reportable = instances.select{ |instance| instance.in_stock? }
      report(title, reportable)
    end

    def out_stock_report
      title = "#{self.to_s} Out of Stock Report"
      reportable = instances.select{ |instance| instance.in_stock? }
      report(title, reportable)
      end
  end

  def stock_count
    @stock_count ||= 0
  end

  def stock_count=(number)
    @stock_count = number
  end

  def in_stock?
    stock_count > 0
  end

end

module Treehouse #Create Treehouse module encapsulating classes for namespace
  class Shirt
    include Inventoryable
    attr_accessor :attributes

    def initialize(attributes)
      @attributes = attributes
    end
  end

  class Pant
    include Inventoryable
    attr_accessor :attributes

    def initialize(attributes)
      @attributes = attributes
    end
  end

  class Accessory
    include Inventoryable
    attr_accessor :attributes

    def initialize(attributes)
      @attributes = attributes
    end
  end
end

shirt = Treehouse::Shirt.create(name: "MTF", size: "L")
shirt.stock_count = 10

shirt = Treehouse::Shirt.create(name: "MTF2", size: "L")
shirt.stock_count = 4

shirt = Treehouse::Shirt.create(name: "MTF", size: "M")
shirt.stock_count = 9

pant = Treehouse::Pant.create(name: "Jeans", size: "M")
pant.stock_count = 2

pant = Treehouse::Pant.create(name: "Jeans", size: "S")
pant.stock_count = 4

accessory = Treehouse::Accessory.create(name: "Belt", size: "M")
accessory.stock_count = 1

accessory = Treehouse::Accessory.create(name: "Belt", size: "L")
accessory.stock_count = 1

accessory = Treehouse::Accessory.create(name: "Necklace")
accessory.stock_count = 1

Treehouse::Shirt.in_stock_report
Treehouse::Pant.in_stock_report
Treehouse::Accessory.in_stock_report

Shirt.out_stock_report
