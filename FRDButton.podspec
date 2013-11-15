Pod::Spec.new do |spec|
  spec.name = 'FRDButton'
  spec.version = '0.1'
  spec.authors = { 'Sebastien Windal' => 'sebastien@windal.net' }
  spec.homepage = 'https://github.com/sebastienwindal/FRDButton'
  spec.summary = 'Buttons, bootstrap/BButton inspired, toned down for use in iOS7 apps.'
  spec.source = { :git => 'https://github.com/sebastienwindal/FRDButton.git', :tag => "#{spec.version}" }
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.platform = :ios
  spec.requires_arc = true
  spec.frameworks = 'UIKit', 'CoreGraphics'
  spec.source_files = 'FRDButton'
  spec.dependency 'EDColor'
end