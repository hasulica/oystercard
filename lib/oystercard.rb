class Oystercard

  attr_reader :balance, :entry_station

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
  end

  def top_up amount
    raise "the limit is #{Oystercard::MAX_BALANCE}" if new_balance(amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail StandardError, "Minimum balance is £#{MIN_BALANCE}" unless @balance >= MIN_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct MIN_FARE
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def new_balance(amount)
    curent_value = balance + amount
  end

  def deduct amount
    @balance -= amount
  end

end
