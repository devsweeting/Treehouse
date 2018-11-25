module Fetcher
  def self.included(klass) #class methods are prefixed with self
    puts "#{klass} has been included"
    attr_accessor :fetch_count
  end


  def fetch(item)
    @fetch_count ||= 0
    @fetch_count += 1
    puts "[#{@name}, Fetch count: #{@fetch_count}] I'll bring that #{item} back!"
   end
end

class Dog
  include Fetcher
  def initialize(name)
    @name = name
   end
end

class Cat
  include Fetcher #must include module name in class to access methods
  def initialize (name)
    @name = name
  end
end


dog = Dog.new("Fido")
dog.fetch("ball")
dog.fetch("butt candy")

cat = Cat.new("Naynay")
cat.fetch("laser pointer")
