command = ARGV[0]

until system command do
  system 'echo "Program crashed..Restarting"'
  system 'sleep 1'
end

