$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "presentations"

desc "Generate presentations.html from presentations.txt"
task :generate do
  FileUtils.mkdir_p './out'
  FileUtils.remove_entry_secure './out/images' if File.exist?('./out/images')
  FileUtils.cp_r './images', './out/images'

  urls = File.readlines("presentations.txt").map(&:chomp)
  presentations = Presentations::Collector.collect(urls)

  open("./out/presentations.html", "w") do |io|
    io.puts Presentations::View::Layout.render(presentations)
  end
end

desc "Put presentations.html to S3"
task :release do
  path = './out/presentations.html'
  unless File.exist?(path)
    abort 'run `rake generate` first'
  end
  html = File.read(path)

  unless ENV['AWS_ACCESS_KEY_ID'] && ENV['AWS_SECRET_ACCESS_KEY']
    abort "Please set your ENV['AWS_ACCESS_KEY_ID'] and ENV['AWS_SECRET_ACCESS_KEY']\nor ask infra team."
  end

  require 'aws-sdk'
  s3 = AWS::S3.new s3_endpoint: 's3-ap-northeast-1.amazonaws.com'
  bucket = s3.buckets['static.cookpad.com']
  obj = bucket.objects['techlife/presentations.html']
  obj.write html, content_type: 'text/html'

  puts "released: http://static.cookpad.com/techlife/presentations.html"
end

desc "Put images to S3"
task :release_images do
  unless ENV['AWS_ACCESS_KEY_ID'] && ENV['AWS_SECRET_ACCESS_KEY']
    abort "Please set your ENV['AWS_ACCESS_KEY_ID'] and ENV['AWS_SECRET_ACCESS_KEY']\nor ask infra team."
  end

  require 'aws-sdk'
  s3 = AWS::S3.new s3_endpoint: 's3-ap-northeast-1.amazonaws.com'
  bucket = s3.buckets['static.cookpad.com']

  %w(head_fg.png image/png
     head_bg.png image/png).each_slice(2) do |name, content_type|

    source = File.join('images', name)
    obj = bucket.objects["techlife/images/#{name}"]

    puts "#{source} -> techlife/images/#{name}"
    obj.write File.binread(source), content_type: content_type
  end

end


task default: :generate
