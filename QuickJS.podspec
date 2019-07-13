Pod::Spec.new do |s|
    s.name         = "QuickJS"
    s.version      = "0.0.2019-07-09"
    s.summary      = "QuickJS Javascript Engine"
    s.homepage     = "https://bellard.org/quickjs/"
    
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { "Francis Chong" => "francis@ignition.hk" } # Podspec maintainer
    s.requires_arc = false
    s.platform     = :ios, "12.0" 
    s.source       = { :http => "https://bellard.org/quickjs/quickjs-2019-07-09.tar.xz" }
    s.default_subspec = 'precompiled'

    s.subspec 'precompiled' do |ss|
      ss.source_files        = 'QuickJS_iOS/*.h'
      ss.public_header_files = 'QuickJS_iOS/*.h'
      ss.header_mappings_dir = 'QuickJS_iOS'
      ss.vendored_libraries  = 'QuickJS_iOS/lib/*.a'

      # required to load all symbols in the library
      ss.user_target_xcconfig = { 'OTHER_LDFLAGS' => '-force_load ${PODS_ROOT}/../../QuickJS_iOS/QuickJS_iOS/lib/libquickjs.a' }
    end
  end
