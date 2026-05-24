#!/usr/bin/env ruby

# Inspired by http://errtheblog.com/posts/89-huba-huba

# This is idempotent, meaning you can run it over and over again without fear of
# breaking anything. Use it as an installer or to upgrade after merging from an
# upstream fork.

home = File.expand_path('~')

Dir['*'].each do |file|
  next if file =~ /install/ || file =~ /README/
  next if file == 'gnupg' # nested config, handled separately below
  if file =~ /^[A-Z]/
    target = File.join(home, file)
  else
    target = File.join(home, ".#{file}")
  end
  `ln -ns #{File.expand_path file} #{target}`
end

# Nested ~/.gnupg config. Symlink only the version-controlled config files into
# ~/.gnupg — never the directory itself, since it holds the secret keyring.
if Dir.exist?('gnupg')
  gnupg_home = File.join(home, '.gnupg')
  `mkdir -p #{gnupg_home} && chmod 700 #{gnupg_home}`
  Dir['gnupg/*'].each do |file|
    target = File.join(gnupg_home, File.basename(file))
    `ln -nsf #{File.expand_path file} #{target}`
  end
end