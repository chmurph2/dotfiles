# See http://github.com/mynyml/watchr/
# This script was modified from http://gist.github.com/raw/189052/1fd4faf0e9edab9d8e941fd21a1a9e7f70cf5aad/specs.watchr.rb
#
# Run me with:
#
#   $ watchr ~/.rails.watchr.rb
#
# or alias me with:
#
# alias rw='watchr ~/.rails.watchr.rb'

def run(cmd)
  puts(cmd)
  system(cmd)
end

def run_all_tests
  cmd = "time rake"
  run(cmd)
end

def ruby_cmd
  "time ruby -rubygems"
end

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch( '^test.*/.*_test\.rb')       { |m| run("#{ruby_cmd} %s" % m[0]) }                                                            # watch all tests
watch( '^lib/(.*)\.rb')             { |m| run("#{ruby_cmd} test/unit/%s_test.rb" % m[1]) }                                          # watch all libs
watch( '^agents/(.*_agent)\.rb')    { |m| run("#{ruby_cmd} agents/%s/test/unit/%s_test.rb".gsub(/%s/, name=m[1].split('/').last)) } # watch all agents
watch( '^app/models/(.*)\.rb')      { |m| run("#{ruby_cmd} test/unit/%s_test.rb" % m[1]) }                                          # watch all models
watch( '^app/controllers/(.*)\.rb') { |m| run("#{ruby_cmd} test/functional/%s_test.rb" % m[1]) }                                    # watch all controllers
watch( '^app/helpers/(.*)\.rb')     { |m| run("#{ruby_cmd} test/unit/%s_test.rb" % m[1]) }                                          # watch all helpers
watch( '^test/test_helper\.rb' )    { run_all_tests }                                                                               # watch test_helper
puts "Every move you make... ♪"

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
# Ctrl-\
Signal.trap('QUIT') do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end

# Ctrl-C
Signal.trap('INT') { abort("\n") }