require 'minitest/reporters'
MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new
require 'minitest/autorun'

############## Page ?? ##############
class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end
  
  def width   # <---- used to be 'diameter'
    rim + (tire * 2)
  end
# ...
end

############## Page ?? ##############
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

############## Page ?? ##############
class Gear
  # ...
  def gear_inches
    ratio * wheel.diameter # <--- obsolete
  end
end

############## Page ?? ##############
class DiameterDouble
  
  def diameter  # The interface changed to 'width',
    10          # but this double and Gear both
  end           # still use 'diameter'.
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

############## Page ?? ##############
class WheelTest < MiniTest::Unit::TestCase
  def setup
    @wheel = Wheel.new(26, 1.5)
  end

  def test_implements_the_diameterizable_interface
    assert_respond_to(@wheel, :width)
  end
  
  def test_calculates_diameter
    # ...
  end  
end

############## Page ?? ##############
module DiameterizableInterfaceTest 
  def test_implements_the_diameterizable_interface
   assert_respond_to(@object, :width)
  end
end

############## Page ?? ##############
class WheelTest < MiniTest::Unit::TestCase
  include DiameterizableInterfaceTest
  
  def setup
    @wheel = @object = Wheel.new(26, 1.5)
  end
  
  def test_calculates_diameter
    # ...
  end  
end

############## Page ?? ##############
class DiameterDouble
  def diameter
    10
  end
end

# Prove the test double honors the interface this
#   test expects. 
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