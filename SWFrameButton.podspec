Pod::Spec.new do |s|
  s.name             = "SWFrameButton"
  s.version          = "1.0.2"
  s.summary          = "iOS7 UIButton with border"
  s.homepage         = "https://github.com/sarunw/SWFrameButton"
  s.license          = 'MIT'
  s.author           = { "Sarun Wongpatcharapakorn" => "artwork.th@gmail.com" }
  s.source           = { :git => "https://github.com/sarunw/SWFrameButton.git", :tag => s.version.to_s }
  s.platform         = :ios, '7.0'
  s.requires_arc     = true
  s.source_files     = 'SWFrameButton/*.{h,m}'
  s.frameworks       = 'QuartzCore'
end
