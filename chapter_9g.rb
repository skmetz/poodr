require 'minitest/reporters'
MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new
require 'minitest/autorun'

############## From previous example ##############
class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end
  
  def width
    rim + (tire * 2)
  end
# ...
end

############## From previous example ##############
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    @chainring = args[:chainring]
    @cog       = args[:cog]
    @wheel     = args[:wheel]
  end

  def gear_inches
    ratio * wheel.diameter
  end
  
  def ratio
    chainring / cog.to_f
  end
# ...
end

############## From previous example ##############
module DiameterizableInterfaceTest 
  def test_implements_the_diameterizable_interface
    assert_respond_to(@object, :width)
  end
end

############## Page 228 ##############
# Full example is below.
class DiameterDouble
  def width 
    10
  end
end

############## Full example, so tests will run.
class DiameterDouble
  def width 
    10
  end
end

class DiameterDoubleTest < MiniTest::Unit::TestCase
  include DiameterizableInterfaceTest
  
  def setup
    @object = DiameterDouble.new
  end
end

class GearTest < MiniTest::Unit::TestCase
  def test_calculates_gear_inches
    gear =  Gear.new(
              chainring: 52, 
              cog:       11, 
              wheel:     DiameterDouble.new)
              
    assert_in_delta(47.27,
                    gear.gear_inches,  
                    0.01)
  end
end

############## Page 228 ##############
# Full listing is below
class Gear

  def gear_inches
                 # finally, 'width' instead of 'diameter'
    ratio * wheel.width
  end

# ...
end

############## Page ??? ##############
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    @chainring = args[:chainring]
    @cog       = args[:cog]
    @wheel     = args[:wheel]
  end

  def gear_inches
    ratio * wheel.width
  end
  
  def ratio
    chainring / cog.to_f
  end
# ...
end

