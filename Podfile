# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

plugin 'cocoapods-keys', {
  :project => "LongWeekend",
    :keys => [
    'AdUnitID',
  ]
}
target 'LongWeekend' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LongWeekend
  pod 'Google-Mobile-Ads-SDK', '11.7.0'

  target 'LongWeekendTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end

