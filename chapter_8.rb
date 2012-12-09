############## Page 165 ##############
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size       = args[:size]
    @parts      = args[:parts]
  end

  def spares
    parts.spares
  end
end

############## Page 165 ##############
class Parts
  attr_reader :chain, :tire_size

  def initialize(args={})
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

class RoadBikeParts < Parts
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

class MountainBikeParts < Parts
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

############## Page 167 ##############
road_bike =
  Bicycle.new(
    size:  'L',
    parts: RoadBikeParts.new(tape_color: 'red'))

road_bike.size    # -> 'L'

road_bike.spares
# -> {:tire_size=>"23",
#     :chain=>"10-speed",
#     :tape_color=>"red"}

mountain_bike =
  Bicycle.new(
    size:  'L',
    parts: MountainBikeParts.new(rear_shock: 'Fox'))

mountain_bike.size   # -> 'L'

mountain_bike.spares
# -> {:tire_size=>"2.1",
#     :chain=>"10-speed",
#     :rear_shock=>"Fox"}

############## Page 169 ##############
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size       = args[:size]
    @parts      = args[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :parts

  def initialize(parts)
    @parts = parts
  end

  def spares
    parts.select {|part| part.needs_spare}
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name         = args[:name]
    @description  = args[:description]
    @needs_spare  = args.fetch(:needs_spare, true)
  end
end

############## Page 170 ##############
chain =
  Part.new(name: 'chain', description: '10-speed')

road_tire =
  Part.new(name: 'tire_size',  description: '23')

tape =
  Part.new(name: 'tape_color', description: 'red')

mountain_tire =
  Part.new(name: 'tire_size',  description: '2.1')

rear_shock =
  Part.new(name: 'rear_shock', description: 'Fox')

front_shock =
  Part.new(
    name: 'front_shock',
    description: 'Manitou',
    needs_spare: false)

############## Page 171 ##############
road_bike_parts =
  Parts.new([chain, road_tire, tape])

############## Page 171 ##############
road_bike =
  Bicycle.new(
    size:  'L',
    parts: Parts.new([chain,
                      road_tire,
                      tape]))

road_bike.size    # -> 'L'

road_bike.spares
# -> [#<Part:0x00000101036770
#         @name="chain",
#         @description="10-speed",
#         @needs_spare=true>,
#     #<Part:0x0000010102dc60
#         @name="tire_size",
#         etc ...

mountain_bike =
  Bicycle.new(
    size:  'L',
    parts: Parts.new([chain,
                      mountain_tire,
                      front_shock,
                      rear_shock]))

mountain_bike.size    # -> 'L'

mountain_bike.spares
# -> [#<Part:0x00000101036770
#         @name="chain",
#         @description="10-speed",
#         @needs_spare=true>,
#     #<Part:0x0000010101b678
#         @name="tire_size",
#         etc ...

############## Page 172 ##############
mountain_bike.spares.size # -> 3
mountain_bike.parts.size
# -> NoMethodError:
#      undefined method `size' for #<Parts:...>

############## Page 173 ##############
  def size
    parts.size
  end

############## Page 173 ##############
class Parts < Array
  def spares
    select {|part| part.needs_spare}
  end
end

############## Page 174 ##############
#  Parts inherits '+' from Array, so you can
#    add two Parts together.
combo_parts =
  (mountain_bike.parts + road_bike.parts)

# '+' definitely combines the Parts
combo_parts.size            # -> 7

# but the object that '+' returns
#   does not understand 'spares'
combo_parts.spares
# -> NoMethodError: undefined method `spares'
#      for #<Array:...>

mountain_bike.parts.class   # -> Parts
road_bike.parts.class       # -> Parts
combo_parts.class           # -> Array !!!

############## Page 175 ##############
require 'forwardable'
class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select {|part| part.needs_spare}
  end
end

############## Page ?? ##############
# Full listing for above
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size       = args[:size]
    @parts      = args[:parts]
  end

  def spares
    parts.spares
  end
end

require 'forwardable'
class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select {|part| part.needs_spare}
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name         = args[:name]
    @description  = args[:description]
    @needs_spare  = args.fetch(:needs_spare, true)
  end
end

#this duplicates #012
chain =
  Part.new(name: 'chain', description: '10-speed')

road_tire =
  Part.new(name: 'tire_size',  description: '23')

tape =
  Part.new(name: 'tape_color', description: 'red')

mountain_tire =
  Part.new(name: 'tire_size',  description: '2.1')

rear_shock =
  Part.new(name: 'rear_shock', description: 'Fox')

front_shock =
  Part.new(
    name: 'front_shock',
    description: 'Manitou',
    needs_spare: false)

############## Page 175 ##############
mountain_bike =
  Bicycle.new(
    size:  'L',
    parts: Parts.new([chain,
                      mountain_tire,
                      front_shock,
                      rear_shock]))

mountain_bike.spares.size   # -> 3
mountain_bike.parts.size    # -> 4

############## Page ??? ##############
mountain_bike.parts + road_bike.parts
# -> NoMethodError: undefined method `+'
#      for #<Parts:....>

############## Page 176 ##############
road_config =
  [['chain',        '10-speed'],
   ['tire_size',    '23'],
   ['tape_color',   'red']]

mountain_config =
  [['chain',        '10-speed'],
   ['tire_size',    '2.1'],
   ['front_shock',  'Manitou', false],
   ['rear_shock',   'Fox']]

############## Page 177 ##############
module PartsFactory
  def self.build(config,
                 part_class  = Part,
                 parts_class = Parts)

    parts_class.new(
      config.collect {|part_config|
        part_class.new(
          name:         part_config[0],
          description:  part_config[1],
          needs_spare:  part_config.fetch(2, true))})
  end
end

############## Page 178 ##############
road_parts = PartsFactory.build(road_config)
# -> [#<Part:0x00000101825b70
#       @name="chain",
#       @description="10-speed",
#       @needs_spare=true>,
#     #<Part:0x00000101825b20
#       @name="tire_size",
#          etc ...

mountain_parts = PartsFactory.build(mountain_config)
# -> [#<Part:0x0000010181ea28
#        @name="chain",
#        @description="10-speed",
#        @needs_spare=true>,
#     #<Part:0x0000010181e9d8
#        @name="tire_size",
#        etc ...

############## Page 179 ##############
class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name         = args[:name]
    @description  = args[:description]
    @needs_spare  = args.fetch(:needs_spare, true)
  end
end

############## Page 179 ##############
require 'ostruct'
module PartsFactory
  def self.build(config, parts_class = Parts)
    parts_class.new(
      config.collect {|part_config|
        create_part(part_config)})
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name:        part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true))
  end
end

############## Page 180 ##############
mountain_parts = PartsFactory.build(mountain_config)
# -> <Parts:0x000001009ad8b8 @parts=
#      [#<OpenStruct name="chain",
#                    description="10-speed",
#                    needs_spare=true>,
#       #<OpenStruct name="tire_size",
#                    description="2.1",
#                    etc ...

############## Page 180 ##############
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size       = args[:size]
    @parts      = args[:parts]
  end

  def spares
    parts.spares
  end
end

require 'forwardable'
class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select {|part| part.needs_spare}
  end
end

require 'ostruct'
module PartsFactory
  def self.build(config, parts_class = Parts)
    parts_class.new(
      config.collect {|part_config|
        create_part(part_config)})
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name:        part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true))
  end
end

road_config =
  [['chain',        '10-speed'],
   ['tire_size',    '23'],
   ['tape_color',   'red']]

mountain_config =
  [['chain',        '10-speed'],
   ['tire_size',    '2.1'],
   ['front_shock',  'Manitou', false],
   ['rear_shock',   'Fox']]

############## Page 182 ##############
road_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(road_config))

road_bike.spares
# -> [#<OpenStruct name="chain", etc ...

mountain_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(mountain_config))

mountain_bike.spares
# -> [#<OpenStruct name="chain", etc ...
#
############## Page 182 ##############
recumbent_config =
  [['chain',        '9-speed'],
   ['tire_size',    '28'],
   ['flag',         'tall and orange']]

recumbent_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(recumbent_config))

recumbent_bike.spares
# -> [#<OpenStruct
#       name="chain",
#       description="9-speed",
#       needs_spare=true>,
#     #<OpenStruct PartsFactory::Part
#       name="tire_size",
#       description="28",
#       needs_spare=true>,
#     #<OpenStruct PartsFactory::Part
#       name="flag",
#       description="tall and orange",
#       needs_spare=true>]
