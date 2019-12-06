Pod::Spec.new do |spec|
  spec.name         = "LBYearCalendar"
  spec.version      = "1.0.2"
  spec.summary      = "超轻量级，超灵活的日历年视图"
  spec.description  = "超轻量级，超灵活的日历年视图"
  spec.homepage     = "https://github.com/A1129434577/LBYearCalendar"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "刘彬" => "1129434577@qq.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = '8.0'
  spec.source       = { :git => 'https://github.com/A1129434577/LBYearCalendar.git', :tag => spec.version.to_s }
  spec.source_files = "LBYearCalendar/**/*.{h,m}"
  spec.requires_arc = true
end
