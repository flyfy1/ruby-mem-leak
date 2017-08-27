class LargeObject
  def initialize
    @data = "x" * 1024 * 1024 * 20
  end
end

def do_something
  obj = LargeObject.new
  trap("TERM") { puts 'oops' } 
end

do_something

# force major GC to make sure we free all objects that can be freed
GC.start(full_mark: true, immediate_sweep: true)
puts "LargeObject instances left in memory: %d" %
  ObjectSpace.each_object(LargeObject).count
