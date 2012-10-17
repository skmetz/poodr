require 'minitest/reporters'
MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new
require 'minitest/autorun'

############## Page 219 ##############
class Mechanic
  def prepare_bicycle(bicycle)
    #...
  end
end

class TripCoordinator
  def buy_food(customers)
    #...
  end
end

class Driver
  def gas_up(vehicle)
    #...
  end
  def fill_water_tank(vehicle)
    #...
  end
end

############## Page 220 ##############
# The full class is below.
class Trip
  attr_reader :bicycles, :customers, :vehicle
  
  def prepare(preparers)
    preparers.each {|preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)     
        preparer.fill_water_tank(vehicle)
      end
    }
  end
end

############## Full example, so tests will run.
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def initialize(args={})
    @bicycles  = args[:bicycles]  ||= []
    @customers = args[:customers] ||= []
    @vehicls   = args[:vehicle]
  end
  
  def prepare(preparers)
    preparers.each {|preparer| 
      preparer.prepare_trip(self)}
  end
end

############## Page 220 ##############
class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each {|bicycle| 
      prepare_bicycle(bicycle)}
  end
  
  # ...
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end
  
  # ...
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end
  # ...
end

############## Page 221 ##############
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each {|preparer| 
      preparer.prepare_trip(self)}
  end
end

############## Page 222 ##############
module PreparerInterfaceTest 
  def test_implements_the_preparer_interface
    assert_respond_to(@object, :prepare_trip)
  end
end

############## Page 222 ##############
class MechanicTest < MiniTest::Unit::TestCase
  include PreparerInterfaceTest
  
  def setup
    @mechanic = @object = Mechanic.new
  end
  
  # other tests which rely on @mechanic
end

############## Page 222 ##############
class TripCoordinatorTest < MiniTest::Unit::TestCase
  include PreparerInterfaceTest
  
  def setup
    @trip_coordinator = @object = TripCoordinator.new
  end
end

class DriverTest < MiniTest::Unit::TestCase
  include PreparerInterfaceTest
  
  def setup
    @driver = @object =  Driver.new
  end
end

############## Page 223 ##############
class TripTest < MiniTest::Unit::TestCase
  
  def test_requests_trip_preparation
    @preparer = MiniTest::Mock.new
    @trip     = Trip.new
    @preparer.expect(:prepare_trip, nil, [@trip])
    
    @trip.prepare([@preparer])
    @preparer.verify
  end
end
