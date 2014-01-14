class Object
  # Return only the methods not present on basic objects
  def interesting_methods
    (self.methods - Object.new.methods).sort
  end
  alias :i :interesting_methods
end

begin
  raise LoadError unless (ENV["TERM"] =~ /xterm/)
  require "pry"
  Pry.start
  exit
rescue LoadError => e
  warn "=> Unable to load pry"
end
