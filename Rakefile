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

task default: :generate
