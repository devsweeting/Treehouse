class Monster
  attr_reader :name, :actions


  def initialize(name)
    @name = name
    @actions = {
      scream: 0,
      scare: 0,
      run: 0
      }
    end

    def inspect
      "<#{name}, #{actions}>"
    end

  def print_scoreboard
    puts"------------------------"
    puts "#{name} scoreboard"
    puts "--------------------------"
    puts "Screams: #{actions[:scream]}"
    puts "Scares: #{actions[:scare]}"
    puts "Run: #{actions[:run]}"
  end

  def say (&block)
    print "#{name} says ... "
    yield
    end

  def scream(&block)
    actions[:scream] += 1
    print ("#{name} screams! ")
    yield
  end

  def scare (&block)
    actions[:scare] += 1
    print "#{name} scares you!"
    yield
 end

   def run (&block)
    actions[:run] += 1
    print "#{name} is chasing you!"
    yield self if block_given?
 end

end

monster = Monster.new("Fluffy")
monster.say {puts "RAWR"}

monster.scream do
  puts "Boo!"
 end

monster.scare do
  puts "Go away!"
end

monster.run do |m|
  puts "boogie woogie"
  puts m.inspect
end

puts "/n"
monster.print_scoreboard
