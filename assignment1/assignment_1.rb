n = 10
instructions = "UDLRLR"

def find_direction(n, instructions)
  leftcount = instructions.count("L")
  rightcount = instructions.count("R")
  direction = (rightcount - leftcount)%4
  if direction==0
    "N"
  elsif direction==1
    "E"
  elsif direction==2
    "S"
  else "W"
  end
end

p find_direction(n, instructions)
