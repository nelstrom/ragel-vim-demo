require 'rake/clean'
CLEAN.include FileList['lib/*.rb', 'lib/*.dot']

desc "Compile each .rl file to .rb"
task :compile do
  FileList.new('lib/*.rl').each do |file|
    system "ragel -R #{file}"
  end
end

desc "Generate a .dot visualization for each .rl file"
task :visualize do
  FileList.new('lib/*.rl').each do |file|
    system "ragel -Vp #{file} > #{file.ext('.dot')}"
  end
end

task :default => :compile
