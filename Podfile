platform :ios, '9.0'

target 'BaseMVP' do
  use_frameworks!
  inhibit_all_warnings!

  pod 'Alamofire'
  pod 'OHHTTPStubs'
  pod 'OHHTTPStubs/Swift'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts "#{target.name}"
  end
end

