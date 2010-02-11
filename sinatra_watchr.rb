# See http://github.com/mynyml/watchr/
# This script was modified from http://gist.github.com/raw/189052/1fd4faf0e9edab9d8e941fd21a1a9e7f70cf5aad/specs.watchr.rb
#
# Run me with:
#
#   $ watchr ~/.sinatra.watchr.rb
#
# or alias me with:
#
# alias sw='watchr ~/.sinatra.watchr.rb'

def run(cmd)
  puts(cmd)
  system(cmd)
  puts "*** #{Time.now} ***\n\n"
end

def run_all_tests
  cmd = "rake"
  run(cmd)
end

def ruby_cmd
  "ruby -rubygems"
end

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch( '.*_test\.rb')            { |m| run("#{ruby_cmd} %s" % m[0]) } # watch all tests
watch( '^([Aa]pp|main)\.rb')     { |m| run_all_tests }                # watch main application
watch( '^test/test_helper\.rb' ) { run_all_tests }                    # watch test_helper
puts "\"I'm gonna live till I die...\""

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