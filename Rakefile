$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "presentations"

desc "Generate presentations.html from presentations.txt"
task :generate do
  urls = File.read("presentations.txt").split("\n")
  output = File.open("presentations.html", "w")
  presentations = Presentations::Collector.collect(urls)
  output.puts Presentations::View::Layout.render(presentations)
end

task default: :generate
