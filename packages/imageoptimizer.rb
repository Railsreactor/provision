package :imageoptimizer do
  apt 'optipng'
  apt 'jpegoptim'

  verify do
    has_apt 'optipng'
    has_apt 'jpegoptim'
    has_executable 'optipng'
    has_executable 'jpegoptim'
  end
end
