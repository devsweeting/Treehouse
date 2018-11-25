#Class methods are used when a method needs to have functionality but it may not be tied to a specific instance of a class. The extend keyword in Ruby will mix behavior in to a class rather than instances of a class.

module Tracking
  def create (name)
    object = new(name)
    instances.push(object)
    return object
  end

  def instances
    @instances ||= []
  end

  def find (name)
    instances.find do |instance|
      instance.name == name
    end
  end
end

class Customer
  extend Tracking
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def to_s
    "[#{@name}]"
  end
end

puts "Customer.instances: %s" % Customer.instances.inspect
puts "Customer.create: %s" % Customer.create("Devin")
puts "Customer.create: %s" % Customer.create("Kate")
puts "Customer.create: %s" % Customer.create("Naynay")
puts "Customer.instances: %s" % Customer.instances.inspect
puts "Customer.find('Devin'): %s" % Customer.find("Devin")
puts "Customer.find('Sean'): %s" % Customer.find("Sean")
