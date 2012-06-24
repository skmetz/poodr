############## Page ?? ##############
class Trip
  attr_reader :bicycles, :customers, :vehicle
 
  # this 'mechanic' argument could be of any class
  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycles)
  end
  
  # ... 
end

# if you happen to pass an instance of *this* class,
# it works
class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each {|bicycle| prepare_bicycle(bicycle)}
  end
  
  def prepare_bicycle(bicycle)
    #...
  end
end

############## Page ?? ##############
# Trip preparation becomes more complicated
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

# when you introduce TripCoordinator and Driver
class TripCoordinator
  def buy_food(customers)
    # ...
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

############## Page ?? ##############
# Trip preparation becomes easier
class Trip
  attr_reader :bicycles, :customers, :vehicle
  
  def prepare(preparers)
    preparers.each {|preparer| 
      preparer.prepare_trip(self)}
  end
end

# when every preparer is a Duck 
# that responds to 'prepare_trip'
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

############## Page ?? ##############
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

############## Page ?? ##############
  if preparer.kind_of?(Mechanic)
    preparer.prepare_bicycles(bicycle) 
  elsif preparer.kind_of?(TripCoordinator)
    preparer.buy_food(customers)
  elsif preparer.kind_of?(Driver)
    preparer.gas_up(vehicle)     
    preparer.fill_water_tank(vehicle)
  end

############## Page ?? ##############
  if preparer.responds_to?(:prepare_bicycles)
    preparer.prepare_bicycles(bicycle) 
  elsif preparer.responds_to?(:buy_food)
    preparer.buy_food(customers)
  elsif preparer.responds_to?(:gas_up)
    preparer.gas_up(vehicle)     
    preparer.fill_water_tank(vehicle)
  end

############## Page ?? ##############
# A convenience wrapper for <tt>find(:first, *args)</tt>. 
# You can pass in all the same arguments to this 
# method as you can to <tt>find(:first)</tt>.
def first(*args)
  if args.any?
    if args.first.kind_of?(Integer) || 
         (loaded? && !args.first.kind_of?(Hash))
      to_a.first(*args)
    else
      apply_finder_options(args.first).first
    end
  else
    find_first
  end
end
# !x