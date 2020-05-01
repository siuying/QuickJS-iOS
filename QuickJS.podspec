Pod::Spec.new do |s|
    s.name         = "QuickJS"
    s.version      = "0.0.2020-04-12"
    s.summary      = "QuickJS Javascript Engine"
    s.homepage     = "https://bellard.org/quickjs/"
    
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { "Francis Chong" => "francis@ignition.hk" } # Podspec maintainer
    s.requires_arc = false
    s.platform     = :ios, "10.0" 
    s.source       = { :git => "https://github.com/siuying/QuickJS-iOS.git", :tag => s.version }
    s.default_subspec = 'precompiled'

    s.prepare_command = 'sh build.sh'

    s.subspec 'precompiled' do |ss|
      ss.source_files        = 'QuickJS_iOS/headers/*.h'
      ss.public_header_files = 'QuickJS_iOS/headers/*.h'
      ss.header_mappings_dir = 'QuickJS_iOS/headers'
      ss.vendored_libraries  = 'QuickJS_iOS/lib/*.a'

      # required to load all symbols in the library
      ss.user_target_xcconfig = { 'OTHER_LDFLAGS' => '-force_load ${PODS_ROOT}/../../QuickJS_iOS/QuickJS_iOS/lib/libquickjs.a' }
    end
  end
