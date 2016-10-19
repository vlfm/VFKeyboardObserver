Pod::Spec.new do |s|
  s.name             = 'VFKeyboardObserver'
  s.version          = '1.0.0'
  s.summary          = 'A simple way to observe keyboard notifications and keyboard properties.'
  s.homepage         = 'https://github.com/vlfm/VFKeyboardObserver'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Valery Fomenko' => 'vlfm@yandex.ru' }
  s.source           = { :git => 'https://github.com/vlfm/VFKeyboardObserver.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'VFKeyboardObserver/Classes/**/*'
end
