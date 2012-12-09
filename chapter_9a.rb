require 'minitest/reporters'
MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new
require 'minitest/autorun'

############## Page 201 ##############
class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end

  def diameter
    rim + (tire * 2)
  end
# ...
end

class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(args)
    @chainring = args[:chainring]
    @cog       = args[:cog]
    @rim       = args[:rim]
    @tire      = args[:tire]
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end

  def ratio
    chainring / cog.to_f
  end
# ...
end

############## Page 203 ##############
class WheelTest < MiniTest::Unit::TestCase

  def test_calculates_diameter
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(29,
                    wheel.diameter,
                    0.01)
  end
end

############## Page 203 ##############
class GearTest < MiniTest::Unit::TestCase

  def test_calculates_gear_inches
    gear =  Gear.new(
              chainring: 52,
              cog:       11,
              rim:       26,
              tire:      1.5 )

    assert_in_delta(137.1,
                    gear.gear_inches,
                    0.01)
  end
end
