require 'rubygems'
begin
  home = File.expand_path('~')
  require 'active_support/core_ext'
  # require my custom IRB utils
  Dir.glob("#{home}/work/dotfiles/irb_utils/*.rb").each do |file|
    require file
  end
rescue LoadError; end
