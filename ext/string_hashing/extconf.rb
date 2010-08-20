require 'mkmf'

extension_name = 'string_hashing'
# should link against the libgmp library
$LDFLAGS << ' -lgmp'

# Sort out the universal vs. single-archicture build problems on MacOS X
if RUBY_PLATFORM.include?( 'darwin' )
  puts "MacOS X build: fixing architecture flags:"

  commonflags = nil
  if ENV['ARCHFLAGS']
    puts "  using the value in ARCHFLAGS environment variable (%p)." % [ ENV['ARCHFLAGS'] ]
    commonflags = ENV['ARCHFLAGS']
  else
    $stderr.puts %{
    ===========   WARNING   ===========
    
    You are building this extension on OS X without setting the 
    ARCHFLAGS environment variable. 
    
    If you are seeing this message, that means that the 
    build will probably fail.

    ===================================
    }.gsub( /^\t+/, '  ' )
  end

  if commonflags
    $CFLAGS.gsub!( /-arch\s+\S+ /, '' )
    $LDFLAGS.gsub!( /-arch\s+\S+ /, '' )
    CONFIG['LDSHARED'].gsub!( /-arch\s+\S+ /, '' )

    $CFLAGS << ' ' << commonflags
    $LDFLAGS << ' ' << commonflags
    CONFIG['LDSHARED'] << ' ' << commonflags
  end
end

if find_header("gmp.h")
  $stderr.puts "Configuring extensions"
  dir_config(extension_name)
  create_makefile(extension_name)
else
  $stderr.puts "Skipping building of C extension"
  # creating foo Makefile to avoid building stuff
  File.open(File.join(File.dirname(__FILE__), "Makefile"), "w"){|f| f.write("all: \ninstall: \n")}
end