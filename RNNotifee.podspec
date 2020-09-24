require 'json'
package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name                = "RNNotifee"
  s.version             = package["version"]
  s.description         = package["description"]
  s.summary             = <<-DESC
                            A feature rich local notifications library for React Native Android & iOS.
                          DESC
  s.homepage            = "https://notifee.app"
  s.license             = package['license']
  s.authors             = "Invertase Limited"
  s.source              = { :git => "https://github.com/notifee/react-native-notifee", :tag => "v#{s.version}" }
  s.social_media_url    = 'http://twitter.com/notifee_app'

  s.ios.deployment_target   = '10.0'
  s.default_subspec = "App"

  s.subspec 'App' do |ss|
    ss.source_files = 'ios/RNNotifee/*.{h,m}'
    ss.dependency 'React-Core'
  end

  s.subspec 'NotifeeExtensionHelper' do |ss|
    ss.source_files = ['ios/RNNotifee/NotifeeExtensionHelper.h', 'ios/RNNotifee/NotifeeExtensionHelper.m'];
    ss.public_header_files = ['ios/RNNotifee/NotifeeExtensionHelper.h']
  end


  if defined?($NotifeeCoreFromSources) && $NotifeeCoreFromSources == true
    # internal dev flag used by Notifee devs, ignore
    Pod::UI.warn "RNNotifee: Using NotifeeCore from sources."
    s.dependency 'NotifeeCore'
  else
    s.ios.vendored_frameworks = 'ios/NotifeeCore.framework'
  end
end
