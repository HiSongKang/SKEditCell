
Pod::Spec.new do |s|
  s.name         = "SKEditCell"
  s.version      = "0.1.1"
  s.summary      = "UITableVeiwCellEdit"
  s.homepage     = "https://github.com/HiSongKang/SKEditCell"
  s.license      = "MIT"
  s.author             = { "HiSongKang" => "846593701@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/HiSongKang/SKEditCell.git", :tag => "0.1.1" }
  s.source_files  = "SKEditCell/SKEditCell/*"
  s.requires_arc = true
  s.dependency 'Masonry'
end
