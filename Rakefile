$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "presentations"

desc "Generate presentations.html from presentations.txt"
task :generate do
  urls = File.read("presentations.txt").split("\n")
  output = File.open("presentations.html", "w")
  presentations = Presentations::Collector.collect(urls)
  output.puts Presentations::View::Layout.render(presentations)
end

desc "Put presentations.html to S3"
task :release do
  path = './presentations.html'
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
