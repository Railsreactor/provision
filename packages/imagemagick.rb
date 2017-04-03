package :imagemagick do
  apt 'imagemagick' do
    pre :install, ['apt-get update']
  end

  apt 'optipng'
  apt 'jpegoptim'
  apt 'ghostscript'
  apt 'libgs-dev'

  verify do
    has_executable 'mogrify'
    has_apt 'optipng'
    has_apt 'jpegoptim'
    has_executable 'optipng'
    has_executable 'jpegoptim'
    has_apt 'ghostscript'
    has_apt 'imagemagick'
  end
end
