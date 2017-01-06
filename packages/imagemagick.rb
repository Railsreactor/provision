package :imagemagick do
  apt 'imagemagick' do
    pre :install, ['apt-get update']
  end
  apt 'optipng'
  apt 'jpegoptim'

  verify do
    has_apt 'imagemagick'
    has_executable 'mogrify'
    has_apt 'optipng'
    has_apt 'jpegoptim'
    has_executable 'optipng'
    has_executable 'jpegoptim'
  end
end
