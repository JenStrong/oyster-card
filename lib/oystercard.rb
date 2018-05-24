require 'pry'
require_relative 'station'
require_relative 'journey'

#undestands the flow of funds required for a journey
class Oystercard
  DEFAULT_VALUE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :exit_station, :journey_history

  def initialize(journey_class = Journey, balance = DEFAULT_VALUE)
    @journey_class = journey_class
    @balance = balance
    @journey_history = {}
  end

  def top_up(amount)
    raise "Balance cannot be above £ #{Oystercard::MAXIMUM_BALANCE}" if full?
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_BALANCE
    @journey_class.new(station)
  end

  def touch_out(station)
    @journey.exit_station = station
    deduct(@journey.fare)
    @journey.finish
    log_journey
  end

private

  def deduct(amount)
    @balance -= amount
  end

  def log_journey
    journey_history[@journey.entry_station] = @journey.exit_station
  end

  def full?
    balance >= MAXIMUM_BALANCE
  end

end
