require 'minitest/reporters'
MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new
require 'minitest/autorun'

############## Page 229 ##############
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

############## Page 230 ##############
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

############## Page ??? ##############
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

############## Page 231 ##############
module BicycleInterfaceTest
  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end
  
  def test_responds_to_default_chain
    assert_respond_to(@object, :default_chain)
  end
  
  def test_responds_to_chain
    assert_respond_to(@object, :chain)
  end
  
  def test_responds_to_size
    assert_respond_to(@object, :size)
  end
  
  def test_responds_to_tire_size
    assert_respond_to(@object, :size)
  end
  
  def test_responds_to_spares
    assert_respond_to(@object, :spares)
  end
end

############## Page 231 ##############
class BicycleTest < MiniTest::Unit::TestCase
  include BicycleInterfaceTest
  
  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
  end
end

class RoadBikeTest < MiniTest::Unit::TestCase
  include BicycleInterfaceTest
  
  def setup
    @bike = @object = RoadBike.new
  end
end

############## Page 233 ##############
module BicycleSubclassTest
  def test_responds_to_post_initialize
    assert_respond_to(@object, :post_initialize)
  end

  def test_responds_to_local_spares
    assert_respond_to(@object, :local_spares)
  end
  
  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end
end

############## Page 233 ##############
class RoadBikeTest < MiniTest::Unit::TestCase
  include BicycleInterfaceTest
  include BicycleSubclassTest
  
  def setup
    @bike = @object = RoadBike.new
  end
end

############## Page 234 ##############
class MountainBikeTest < MiniTest::Unit::TestCase
  include BicycleInterfaceTest
  include BicycleSubclassTest
  
  def setup
    @bike = @object = MountainBike.new
  end
end

############## Page 235 ##############
class BicycleTest < MiniTest::Unit::TestCase
  include BicycleInterfaceTest
  
  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
  end
  
  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) {@bike.default_tire_size}
  end
end

############## Page 236 ##############
class RoadBikeTest < MiniTest::Unit::TestCase
  include BicycleInterfaceTest
  include BicycleSubclassTest
  
  def setup
    @bike = @object = RoadBike.new(tape_color: 'red')
  end
  
  def test_puts_tape_color_in_local_spares
    assert_equal 'red', @bike.local_spares[:tape_color]
  end
end

############## Page 238 ##############
class StubbedBike < Bicycle
  def default_tire_size
    0
  end
  def local_spares
    {saddle: 'painful'}
  end
end

class BicycleTest < MiniTest::Unit::TestCase
  include BicycleInterfaceTest
  
  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
    @stubbed_bike   = StubbedBike.new
  end
  
  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) {
      @bike.default_tire_size}
  end
  
  def test_includes_local_spares_in_spares
    assert_equal @stubbed_bike.spares, 
                 { tire_size: 0, 
                   chain:     '10-speed', 
                   saddle:    'painful'}
  end
end

############## Page 239 ##############
class StubbedBikeTest < MiniTest::Unit::TestCase
  include BicycleSubclassTest
  
  def setup
    @object = StubbedBike.new
  end
end
