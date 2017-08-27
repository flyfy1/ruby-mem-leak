module Logger
  extend self

  attr_accessor :output, :log_actions


  def log(line)
    self.log_actions ||= []
    self.log_actions << line
  end


  def play
    log_actions.each { |line| puts line }
  end
end


class Thing
  def initialize(id)
    Logger.log "created thing #{id}"
  end
end


def do_something
  1000.times { |i| Thing.new(i) }
end

do_something
Logger.play
Logger.log_actions = []

GC.start
puts ObjectSpace.each_object(Thing).count
