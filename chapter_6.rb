############## Page ?? ##############
class Bicycle
  attr_reader :size, :tape_color
  
  def initialize(args)
    @size       = args[:size]
    @tape_color = args[:tape_color]
  end
  
  # every bike has the same defaults for 
  # tire and chain size
  def spares
    { chain:        '10-speed', 
      tire_size:    '23', 
      tape_color:   tape_color}
  end
  
  # Many other methods...
end

bike = Bicycle.new(
        size:       'M', 
        tape_color: 'red' )

bike.size     # -> 'M'                   
bike.spares
# -> {:tire_size   => "23", 
#     :chain       => "10-speed", 
#     :tape_color  => "red"}

############## Page ?? ##############
class Bicycle
  attr_reader :style, :size, :tape_color, 
              :front_shock, :rear_shock
  
  def initialize(args)
    @type        = args[:style]
    @size        = args[:size]
    @tape_color  = args[:tape_color]
    @front_shock = args[:front_shock]
    @rear_shock  = args[:rear_shock]
  end
  
  # checking 'style' starts down a slippery slope
  def spares
    if style == :road
      { chain:        '10-speed', 
        tire_size:    '23',       # milimeters
        tape_color:   tape_color }
    else
      { chain:        '10-speed', 
        tire_size:    '2.1',      # inches
        rear_shock:   rear_shock }
    end
  end
end

bike = Bicycle.new(
        style:        :mountain,
        size:         'S', 
        front_shock:  'Manitou',
        rear_shock:   'Fox')

bike.spares
# -> {:tire_size   => "2.1", 
#     :chain       => "10-speed",
#     :rear_shock  => 'Fox'}

############## Page ?? ##############
class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock
  
  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock  = args[:rear_shock]
    super(args)
  end
  
  def spares
    super.merge(rear_shock: rear_shock)
  end
end

############## Page ?? ##############
mountain_bike = MountainBike.new(
                  size:         'S', 
                  front_shock:  'Manitou',
                  rear_shock:   'Fox')

mountain_bike.size # -> 'S'

mountain_bike.spares
# -> {:tire_size   => "23",       <- wrong!
#     :chain       => "10-speed", 
#     :tape_color  => nil,        <- not applicable
#     :front_shock => 'Manitou',
#     :rear_shock  => "Fox"} 

############## Page ?? ##############
class Bicycle
  # This class is now empty.
  # All code has been moved to RoadBike.
end

class RoadBike < Bicycle
  # Now a subclass of Bicycle.
  # Contains all code from the old Bicycle class.
end

class MountainBike < Bicycle
  # Still a subclass of Bicycle (which is now empty).
  # Code has not changed.
end

############## Page ?? ##############
road_bike = RoadBike.new(
              size:       'M', 
              tape_color: 'red' )

road_bike.size  # => "M" 

mountain_bike = MountainBike.new(
                  size:         'S', 
                  front_shock:  'Manitou',
                  rear_shock:   'Fox')

mountain_bike.size
# NoMethodError: undefined method `size'

############## Complete ?? ##############
# This is the complete code for example above
class Bicycle
  # This class is now empty.
  # All code has been moved to RoadBike.
end

class RoadBike < Bicycle
  attr_reader :size, :tape_color
  
  def initialize(args)
    @size       = args[:size]
    @tape_color = args[:tape_color]
  end
  
  def spares
    { chain:        '10-speed', 
      tire_size:    '23', 
      tape_color:   tape_color}
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock
  
  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock =  args[:rear_shock]
    super(args)
  end
  
  def spares
    super.merge({rear_shock:  rear_shock})
  end
end

road_bike = RoadBike.new(
              size:       'M', 
              tape_color: 'red' )

road_bike.size  # => "M" 

mountain_bike = MountainBike.new(
                  size:         'S', 
                  front_shock:  'Manitou',
                  rear_shock:   'Fox')

mountain_bike.size
# NoMethodError: undefined method `size'

############## Page ?? ##############
class Bicycle
  attr_reader :size     # <- promoted from RoadBike
  
  def initialize(args={})
    @size = args[:size] # <- promoted from RoadBike    
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color
  
  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)  # <- RoadBike now MUST send 'super'
  end
  # ...
end  

############## Page ?? ##############
road_bike = RoadBike.new(
              size:       'M', 
              tape_color: 'red' )

road_bike.size  # -> "M" 

mountain_bike = MountainBike.new(
                  size:         'S', 
                  front_shock:  'Manitou',
                  rear_shock:   'Fox')

mountain_bike.size # -> 'S'

############## Page ?? ##############
class Bicycle
  attr_reader :size
  
  def initialize(args={})
    @size = args[:size]
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color
  
  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end
  
  def spares
    { chain:        '10-speed', 
      tire_size:    '23', 
      tape_color:   tape_color}
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock
  
  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock =  args[:rear_shock]
    super(args)
  end
  
  def spares
    super.merge({rear_shock:  rear_shock})
  end
end

road_bike = RoadBike.new(
              size:       'M', 
              tape_color: 'red' )

road_bike.size  # => "M" 

mountain_bike = MountainBike.new(
                  size:         'S', 
                  front_shock:  'Manitou',
                  rear_shock:   'Fox')

mountain_bike.size # -> 'S'

############## Page ?? ##############
class MountainBike < Bicycle
  # ...
  def spares
    super.merge({rear_shock:  rear_shock})
  end
end

############## Page ?? ##############
mountain_bike.spares
# NoMethodError: super: no superclass method `spares' 

############## Page ?? ##############
class RoadBike < Bicycle
  # ...
  def spares
    { chain:        '10-speed', 
      tire_size:    '23', 
      tape_color:   tape_color}
  end
end

############## Page ?? ##############
class Bicycle
  attr_reader :size, :chain, :tire_size
  
  def initialize(args={})
    @size       = args[:size]
    @chain      = args[:chain]      
    @tire_size  = args[:tire_size]  
  end
  # ...  
end

############## Page ?? ##############
class Bicycle
  attr_reader :size, :chain, :tire_size
  
  def initialize(args={})
    @size       = args[:size]
    @chain      = args[:chain]     || default_chain
    @tire_size  = args[:tire_size] || default_tire_size
  end

  def default_chain       # <- common default 
    '10-speed'
  end
end

class RoadBike < Bicycle
  # ...
  def default_tire_size   # <- subclass default 
    '23'
  end
end

class MountainBike < Bicycle
  # ...
  def default_tire_size   # <- subclass default
    '2.1'
  end
end

############## Page ?? ##############
road_bike = RoadBike.new(
              size:       'M', 
              tape_color: 'red' )

road_bike.tire_size     # => '23'
road_bike.chain         # => "10-speed" 

mountain_bike = MountainBike.new(
                  size:         'S', 
                  front_shock:  'Manitou',
                  rear_shock:   'Fox')

mountain_bike.tire_size # => '2.1'
road_bike.chain         # => "10-speed"

############## Page ?? ##############
class RecumbentBike < Bicycle
  def default_chain
    '9-speed'
  end
end

bent = RecumbentBike.new
# NameError: undefined local variable or method
#   `default_tire_size'

############## Page ?? ##############
  # This line of code is a time bomb
  @tire_size  = args[:tire_size]  || default_tire_size

############## Page ?? ##############
class Bicycle
  #...
  def default_tire_size
    raise NotImplementedError
  end
end

############## Page ?? ##############
bent = RecumbentBike.new
#  NotImplementedError: NotImplementedError

############## Page ?? ##############
class Bicycle
  #...
  def default_tire_size
    raise NotImplementedError, 
          "This #{self.class} cannot respond to:"
  end
end

############## Page ?? ##############
bent = RecumbentBike.new
#  NotImplementedError: 
#    This RecumbentBike cannot respond to:
#	     `default_tire_size'

############## Page ?? ##############
class Bicycle
  #...
  def spares
    { tire_size:  tire_size, 
      chain:      chain}
  end
end

############## Page ?? ##############
class Bicycle
  attr_reader :size, :chain, :tire_size
  
  def initialize(args={})
    @size       = args[:size]
    @chain      = args[:chain]      || default_chain
    @tire_size  = args[:tire_size]  || default_tire_size
  end
  
  def spares
    { tire_size:  tire_size, 
      chain:      chain}
  end
  
  def default_chain
    '10-speed'
  end
  
  def default_tire_size
    raise NotImplememtedError
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color
  
  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end

  def spares
    super.merge({ tape_color: tape_color})
  end
  
  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock
  
  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock =  args[:rear_shock]
    super(args)
  end

  def spares    
    super.merge({rear_shock: rear_shock})
  end

  def default_tire_size
    '2.1'
  end
end

############## Page ?? ##############
##### Results for 40, just in case I decide I need them
road_bike = RoadBike.new(
              size:       'M', 
              tape_color: 'red' )

road_bike.spares
# -> {:tire_size   => "23", 
#     :chain       => "10-speed", 
#     :tape_color  => "red"} 

mountain_bike = MountainBike.new(
                  size:         'S', 
                  front_shock:  'Manitou',
                  rear_shock:   'Fox')

mountain_bike.spares
# -> {:tire_size   => "2.1", 
#     :chain       => "10-speed", 
#     :rear_shock  => "Fox"} 

############## Page ?? ##############
class RecumbentBike < Bicycle
  attr_reader :flag
  
  def initialize(args)
    @flag = args[:flag]  # forgot to send 'super'
  end
  
  def spares
    super.merge({flag: flag})
  end
  
  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end
end

bent = RecumbentBike.new(flag: 'tall and orange')
bent.spares
# -> {:tire_size => nil, <- didn't get initialized
#     :chain     => nil, 
#     :flag      => "tall and orange"} 

############## Page ?? ##############
class Bicycle

  def initialize(args={})
    @size       = args[:size]
    @chain      = args[:chain]     || default_chain
    @tire_size  = args[:tire_size] || default_tire_size

    post_initialize(args)    # Bicycle both sends
  end
  
  def post_initialize(args)  # and implements this
    nil
  end
  # ...
end

class RoadBike < Bicycle
                              
  def post_initialize(args)         # RoadBike can 
    @tape_color = args[:tape_color] # optionally 
  end                               # override it
  # ...
end

############## Page ?? ##############
class Bicycle
  attr_reader :size, :chain, :tire_size
  
  def initialize(args={})
    @size       = args[:size]
    @chain      = args[:chain]     || default_chain
    @tire_size  = args[:tire_size] || default_tire_size
    post_initialize(args)
  end
  
  def post_initialize(args)
    nil
  end
  
  def spares
    { tire_size:  tire_size, 
      chain:      chain}
  end
  
  def default_chain
    '10-speed'
  end
  
  def default_tire_size
    raise NotImplementedError
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color
  
  def post_initialize(args)
    @tape_color = args[:tape_color]
  end
  
  def spares
    super.merge({tape_color: tape_color})
  end
  
  def default_tire_size
    '23'
  end
end

road_bike = RoadBike.new(
              size:       'M', 
              tire_size:  25, 
              tape_color: 'red' )

road_bike.spares

############## Page ?? ##############
class Bicycle
  # ...
  def spares
    { tire_size: tire_size,
      chain:     chain}.merge(local_spares)
  end
  
  # hook for subclasses to override
  def local_spares
    {}
  end
end

class RoadBike < Bicycle
  # ...
  def local_spares
    {tape_color: tape_color}
  end
end

############## Page ?? ##############
# This is the complete code for example above
class Bicycle
  attr_reader :size, :chain, :tire_size
  
  def initialize(args={})
    @size       = args[:size]
    @chain      = args[:chain]      || default_chain
    @tire_size  = args[:tire_size]  || default_tire_size
    post_initialize(args)
  end
  
  def post_initialize(args)
    nil
  end
  
  def spares
    { tire_size: tire_size,
      chain:     chain}.merge(local_spares)
  end
  
  def local_spares
    {}
  end
  
  def default_chain
    '10-speed'
  end
  
  def default_tire_size
    raise NotImplementedError
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color
  
  def post_initialize(args)
    @tape_color = args[:tape_color]
  end
  
  def local_spares
    {tape_color: tape_color}
  end
  
  def default_tire_size
    '23'
  end
end

road_bike = RoadBike.new(
              size:       'M', 
              tire_size:  25, 
              tape_color: 'red' )
road_bike.spares
# -> {:tire_size   => 25, 
#     :chain       => "10-speed", 
#     :tape_color  => "red"}

############## Page ?? ##############
class Bicycle
  attr_reader :size, :chain, :tire_size
  
  def initialize(args={})
    @size       = args[:size]
    @chain      = args[:chain]     || default_chain
    @tire_size  = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def spares
    { tire_size: tire_size,
      chain:     chain}.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  # subclasses may override
  def post_initialize(args)
    nil
  end

  def local_spares
    {}
  end
  
  def default_chain
    '10-speed'
  end
  
end

class RoadBike < Bicycle
  attr_reader :tape_color
  
  def post_initialize(args)
    @tape_color = args[:tape_color]
  end
  
  def local_spares
    {tape_color: tape_color}
  end
  
  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock
  
  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock =  args[:rear_shock]
  end

  def local_spares
    {rear_shock:  rear_shock}
  end

  def default_tire_size
    '2.1'
  end
end

############## Page ?? ##############
class RecumbentBike < Bicycle
  attr_reader :flag
  
  def post_initialize(args)
    @flag = args[:flag]
  end
  
  def local_spares
    {flag: flag}
  end

  def default_chain
    '9-speed'
  end
  
  def default_tire_size
    '28'
  end
end

bent = RecumbentBike.new(flag: 'tall and orange')
bent.spares
# -> {:tire_size => "28", 
#     :chain     => "10-speed", 
#     :flag      => "tall and orange"} 