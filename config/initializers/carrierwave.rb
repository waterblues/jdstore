CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = ENV["qBfiuOpWDXZPOVHREe7PKQGK8fop9bXsqxc0jVIm"]
  config.qiniu_secret_key    = ENV["mARxfcLQTtGFWFOa-WWb_NluhO7C4mxCXiZKwS8f"]
  config.qiniu_bucket        = ENV["jdstore-demo"]
  config.qiniu_bucket_domain = ENV["ou7grz7ha.bkt.clouddn.com"]
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"
  config.qiniu_up_host       = "http://up.qiniug.com"  #选择不同的区域时，"up.qiniug.com" 不同

end
