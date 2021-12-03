

command = ARGV[0]

spawn(command)
Process.wait
puts $?.exitstatus

while $?.exitstatus do
  sleep 1
  spawn(command)
  Process.wait
end

