gem 'rake'
require 'rake/testtask'
require 'rake/clean'
CLEAN.include FileList['lib/*.rb', 'lib/*.dot']

desc "Compile each .rl file to .rb"
task :ragel do
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

Rake::TestTask.new(:test => :ragel) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = false
end

task :default => :test
