Pod::Spec.new do |s|
   s.name = 'CoreTransport'
   s.version = '1.0'
   s.license = 'AGIMA'

   s.summary = 'Lib CoreTransport'
   s.homepage = 'https://github.com/Klimowsa/CoreTransport'
   s.author = 'RMR + AGIMA'

   s.source = { :git => 'https://github.com/Klimowsa/CoreTransport.git', :tag => s.version }
   s.source_files = 'Source/'

   s.ios.deployment_target = '8.0'
   s.osx.deployment_target = '10.10'

   s.frameworks = 'CoreData'

   s.requires_arc = true
end