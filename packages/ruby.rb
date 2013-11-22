package :ruby do
  description 'Setup Ruby'
  version '2.0.0'
  patch_level = 'p353'

  source "ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-#{version}-#{patch_level}.tar.gz"

  verify do
    has_executable_with_version 'ruby', "#{version}#{patch_level}"
  end

  requires :build_essential, :ruby_dependencies
end