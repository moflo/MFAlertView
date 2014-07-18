Pod::Spec.new do |s|
  s.name         = "MFAlertView"
  s.version      = "1.0.0"
  s.summary      = "Custom alert view with blocks, optional spinner and custom styles."
  s.description  = <<-DESC
                    MFAlertView is a custom alert view, rewrite of UIAlertView with blocks, optional spinner and custom styles.
                   DESC
  s.homepage     = "https://github.com/moflo/MFAlertView"
  s.license      = 'MIT'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Mo Flo" => "github@moflo.me" }
  s.source       = { :git => "https://github.com/moflo/MFAlertView.git", :tag => "1.0.0" }
  s.platform     = :ios

  s.source_files = 'MFAlertView/MF_UIAlertView/*.{h,m}'

  s.frameworks  = 'QuartzCore'

  s.requires_arc = true
end