

command = ARGV[0]

Process.spawn(command)
Process.wait

while $?.exitstatus != 0 do
  sleep 1
  spawn(command)
  Process.wait
end
