# See http://github.com/mynyml/watchr/
# This script was modified from http://gist.github.com/raw/276317/45b7ca8a20f0585acc46bc75fade09a260155a61/tests.watchr
#
# For this to run you’ll need to place the standard “passing.png”, “failing.png” images in a “~/.watchr_images” folder,
# and you’ll need growlnotify in your path. It currently only handles passing and failing cases.
# In theory you can just get rid of the growl pieces and use ‘system’ to run the commands instead of backticks,
# but I wanted growl to notify me as I code, rather than having to watch my terminal.
#
# Run me with:
#
#   $ watchr ~/.rails.watchr.rb
#
# or alias me with:
#
# alias rw='watchr ~/.rails.watchr.rb'


ENV["WATCHR"] = "1"
system 'clear'

def growl(message)
  growlnotify = `which growlnotify`.chomp
  title = "Watchr Test Results"
  image = message.include?('0 failures, 0 errors') ? "~/.watchr_images/rails_pass.png" : "~/.watchr_images/rails_fail.png"
  options = "-w -n Watchr --image '#{File.expand_path(image)}' -m '#{message}' '#{title}'"
  system %(#{growlnotify} #{options} &)
end

def run(cmd)
  puts(cmd)
  # system(cmd)
  `#{cmd}`
end

def run_test_file(file)
  system('clear')
  result = run(%Q(ruby -I"lib:test" -rubygems #{file}))
  growl result.split("\n").last rescue nil
  puts result
end

def run_all_tests
  system('clear')
  result = run "rake test"
  puts result
end

def related_test_files(path)
  Dir['test/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_test.rb/ }
end


# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch('test/test_helper\.rb')    { run_all_tests }                                             # watch test_helper
watch('test/.*/.*_test\.rb')     { |m| run_test_file(m[0]) }                                     # watch all tests
watch('(app/lib)/.*/.*\.rb')     { |m| related_test_files(m[0]).map {|tf| run_test_file(tf) } }  # watch app and lib folders
# watch( '^agents/(.*_agent)\.rb') do |m|                                                        # watch all agents
#   name = m[1].split('/').last
#   name_sans_agent = name.gsub(/_agent/, '')
#   run("#{ruby_cmd} agents/%s/test/unit/%s_test.rb" % [name_sans_agent, name])
# end
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
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    # raise Interrupt, nil # let the run loop catch it
    run_all_tests
  end
end