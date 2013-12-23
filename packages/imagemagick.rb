package :imagemagick do
  apt 'imagemagick'

  verify do
    has_apt 'imagemagick'
    has_executable 'mogrify'
  end
end
