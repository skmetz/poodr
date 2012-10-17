############## Page 18 ##############
chainring = 52                    # number of teeth
cog       = 11                    
ratio     = chainring / cog.to_f
puts ratio                        # -> 4.72727272727273

chainring = 30                    
cog       = 27                    
ratio     = chainring / cog.to_f
puts ratio                        # -> 1.11111111111111

############## Page 19 ##############
class Gear
  attr_reader :chainring, :cog
  def initialize(chainring, cog)
    @chainring = chainring
    @cog       = cog
  end
  
  def ratio
    chainring / cog.to_f
  end
end

puts Gear.new(52, 11).ratio        # -> 4.72727272727273
puts Gear.new(30, 27).ratio        # -> 1.11111111111111 

############## Page 20 ##############
class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end
  
  def ratio
    chainring / cog.to_f
  end

  def gear_inches
      # tire goes around rim twice for diameter
    ratio * (rim + (tire * 2))
  end
end

puts Gear.new(52, 11, 26, 1.5).gear_inches  
# -> 137.090909090909

puts Gear.new(52, 11, 24, 1.25).gear_inches 
# -> 125.272727272727

############## Page 20 ##############
puts Gear.new(52, 11).ratio # didn't this used to work?
# ArgumentError: wrong number of arguments (2 for 4)
#	 from (irb):20:in `initialize'
#	 from (irb):20:in `new'
#	 from (irb):20

############## Page 24 ##############
class Gear
  def initialize(chainring, cog)
    @chainring = chainring
    @cog       = cog
  end

  def ratio
    @chainring / @cog.to_f      # <-- road to ruin
  end
end

############## Page 25 ##############
class Gear
  attr_reader :chainring, :cog  # <-------
  def initialize(chainring, cog)
    @chainring = chainring
    @cog       = cog
  end

  def ratio
    chainring / cog.to_f        # <-------
  end
end

############## Page 25 ##############
  # default implementation via attr_reader
  def cog
    @cog
  end

############## Page 25 ##############
  # a simple reimplementation of cog
  def cog
    @cog * unanticipated_adjustment_factor
  end

############## Page 25 ##############
  # a more complex one
  def cog
    @cog * (foo? ? bar_adjustment : baz_adjustment)
  end

############## Page 26 ##############
class ObscuringReferences
  attr_reader :data
  def initialize(data)
    @data = data
  end
  
  def diameters
    # 0 is rim, 1 is tire
    data.collect {|cell| 
      cell[0] + (cell[1] * 2)}
  end
  # ... many other methods that index into the array
end  

############## Page 27 ##############
# rim and tire sizes (now in milimeters!) in a 2d array
@data = [[622, 20], [622, 23], [559, 30], [559, 40]]

############## Page 28 ##############
class RevealingReferences
  attr_reader :wheels
  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect {|wheel| 
      wheel.rim + (wheel.tire * 2)}
  end
  # ... now everyone can send rim/tire to wheel

  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect {|cell| 
      Wheel.new(cell[0], cell[1])}
  end
end

############## Page 29 ##############
  def diameters
    wheels.collect {|wheel| 
      wheel.rim + (wheel.tire * 2)}
  end

############## Page 29 ##############
  # first - iterate over the array
  def diameters
    wheels.collect {|wheel| diameter(wheel)}
  end

  # second - calculate diameter of ONE wheel
  def diameter(wheel)
    wheel.rim + (wheel.tire * 2)
  end

############## Page 30 ##############
  def gear_inches
      # tire goes around rim twice for diameter
    ratio * (rim + (tire * 2))
  end

############## Page 30 ##############
  def gear_inches
    ratio * diameter
  end
  
  def diameter
    rim + (tire * 2)
  end

############## Page 32 ##############
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @wheel     = Wheel.new(rim, tire)
  end
  
  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end

  Wheel = Struct.new(:rim, :tire) do
    def diameter
      rim + (tire * 2)
    end
  end
end

############## Page 33 ##############
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel=nil)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end
  
  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end
end

class Wheel
  attr_reader :rim, :tire
  
  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end
  
  def diameter
    rim + (tire * 2)
  end

  def circumference
    diameter * Math::PI
  end
end

@wheel = Wheel.new(26, 1.5)
puts @wheel.circumference                 
# -> 91.106186954104

puts Gear.new(52, 11, @wheel).gear_inches 
# -> 137.090909090909

puts Gear.new(52, 11).ratio               
# -> 4.72727272727273

