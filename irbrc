IRB.conf[:PROMPT_MODE] = :SIMPLE

require 'rubygems'
begin
  home = File.expand_path('~')
  require 'active_support/core_ext'
  require 'irb/completion'
  require 'irb/ext/save-history'
  # require my custom IRB utils
  Dir.glob("#{home}/work/dotfiles/irb_utils/*.rb").each do |file|
    require file
  end
rescue LoadError; end

# adds readline functionality
IRB.conf[:USE_READLINE] = true
# auto indents suites
IRB.conf[:AUTO_INDENT] = true
# where history is saved
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"
# how many lines to save
IRB.conf[:SAVE_HISTORY] = 1000

# don't save duplicates
IRB.conf[:AT_EXIT].unshift Proc.new {
  no_dups = []
  Readline::HISTORY.each_with_index { |e,i|
    begin
      no_dups << e if Readline::HISTORY[i] != Readline::HISTORY[i+1]
    rescue IndexError
    end
  }
  Readline::HISTORY.clear
  no_dups.each { |e|
    Readline::HISTORY.push e
  }
}