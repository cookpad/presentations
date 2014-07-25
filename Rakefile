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
    $stderr.puts "run `rake generate` first"
    exit 1
  end
  html = File.read(path)

  unless ENV['AWS_ACCESS_KEY_ID'] && ENV['AWS_SECRET_ACCESS_KEY']
    $stderr.puts "Please set your ENV['AWS_ACCESS_KEY_ID'] and ENV['AWS_SECRET_ACCESS_KEY']"
    $stderr.puts "or ask infra team."
    exit 1
  end

  require 'aws-sdk'
  s3 = AWS::S3.new s3_endpoint: 's3-ap-northeast-1.amazonaws.com'
  bucket = s3.buckets['static.cookpad.com']
  obj = bucket.objects['techlife/presentations.html']
  obj.write html, content_type: 'text/html'

  puts "released: http://static.cookpad.com/techlife/presentations.html"
end

task default: :generate
