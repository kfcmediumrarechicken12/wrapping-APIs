#-------------------------------------------------------------
# Exercise 5 Part 1 (Exception Handling)
#-------------------------------------------------------------

class MentalState
  def auditable?
    # true if the external service is online, otherwise false
  end
  def audit!
    # Could fail if external service is offline
  end
  def do_work
    # Amazing stuff...
  end
end

def audit_sanity(bedtime_mental_state)
  raise "Audit Service offline" unless bedtime_mental_state.auditable?

  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

begin
  new_state = audit_sanity(bedtime_mental_state)
rescue => e
  puts "Audit Failed: #{e.message}"
end

#-------------------------------------------------------------
# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)
#-------------------------------------------------------------

class BedtimeMentalState < MentalState ; end

class MorningMentalState < MentalState ; end

class NullMentalState < MentalState
  def do_work
  end
end

def audit_sanity(bedtime_mental_state)
  return NullMentalState.new unless bedtime_mental_state.auditable?

  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

new_state = audit_sanity(bedtime_mental_state)
new_state.do_work

#-------------------------------------------------------------
# Exercise 5 Part 3 (Wrapping APIs)
#-------------------------------------------------------------

require 'candy_service'

class CandyMachineWrapper
  def initialize
    @machine = CandyMachine.new
  end

  def make_candy
    @machine.prepare
    raise "Candy machine not ready" unless @machine.ready?

    @machine.make!
  end
end

begin
  CandyMachineWrapper.new.make_candy
rescue => e
  puts "Candy process failed: #{e.message}"
end