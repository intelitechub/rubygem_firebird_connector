#!/usr/bin/env ruby
# = Windows
# === Sample of Makefile creation:
# <tt>ruby extconf.rb --with-opt-dir=C:/Progra~1/Firebird/Firebird_2_5</tt>
# === Notes
# * Windows is known to build with Ruby from rubyinstaller.org.
# * New in this release is automatically finding your Firebird install under Program Files.
# * If your install is some place non-standard (or on a non-English version of Windows), you'll need to run extconf.rb manually as above.
# * mkmf doesn't like directories with spaces, hence the 8.3 notation in the example above.
# = Linux
# === Notes
# * Build seems to "just work."
# * Unit tests take about 10 times as long to complete using Firebird Classic.  Default xinetd.conf settings may not allow the tests to complete due to the frequency with which new attachments are made.
# = Mac OS X (Intel)
# * Works
WINDOWS_PLATFORMS = /(mingw32|mswin32|x64-mingw-ucrt)/

if ARGV.grep(/^--with-opt-dir=/).empty?
  ARGV << "-- --with-opt-dir='#{ENV['FIREBIRD_PATH']}'"
end

puts "ARGV: #{ARGV.to_s}"

require 'mkmf'

libs = %w/ fbclient /

case RUBY_PLATFORM
  when WINDOWS_PLATFORMS
    $CFLAGS  = $CFLAGS + " -DOS_WIN32"
  when /linux/
    $CFLAGS  = $CFLAGS + " -DOS_UNIX"
end

dir_config("firebird")

test_func = "isc_attach_database"

case RUBY_PLATFORM
when WINDOWS_PLATFORMS
  libs.find {|lib| have_library(lib) } and have_func(test_func, ["ibase.h"])
else
  libs.find {|lib| have_library(lib, test_func) }
end

create_makefile("fb")