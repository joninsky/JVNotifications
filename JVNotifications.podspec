Pod::Spec.new do |s|
s.name             = "JVNotifications"
s.version          = "0.1.0"
s.summary          = "Facebook style notification persistence"
s.description      = <<-DESC
This will allow you to manage notifications and persist them using Realm
                   DESC

s.homepage         = "https://github.com/joninsky/JVNotifications.git"
s.license          = 'MIT'
s.author           = { "pebblebee" => "dev@pebblebee.com" }
s.source           = { :git => "https://github.com/joninsky/JVNotifications.git", :tag => s.version.to_s}
#pod spec lint

s.platform     = :ios, '9.0'
s.requires_arc = true
s.dependency 'RealmSwift'

s.source_files = "JVNotifications/**/*"
s.resources = "JVNotifications/**/*.{png, mp3, mp4, m4a}"
s.resource_bundles = {
    'JVNotificationBunble' => [
        "JVNotifications/**/*.{png}", "JVNotifications/**/*.{m4a}", "JVNotifications/**/*.{mp3}", "JVNotifications/**/*.{mp4}"
    ]
}
end