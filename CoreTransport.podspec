Pod::Spec.new do |s|
   s.name = 'CoreTransport'
   s.version = '1.0'
   s.license = 'MIT'

   s.summary = 'Lib CoreTransport'
   s.homepage = 'https://github.com/Klimowsa/CoreTransport'
   s.author = 'RMR + AGIMA'

   s.source = { :git => 'https://github.com/Klimowsa/CoreTransport.git', :tag => s.version }
   s.source_files = 'Source/CoreTransport/**/*.{h,m}'

   s.platform = :ios
   s.ios.deployment_target = '8.0'

   s.frameworks = 'Realm'
   s.dependency 'AFNetworking'
   s.dependency 'jetfire'
   s.dependency 'Realm'

   s.requires_arc = true
end