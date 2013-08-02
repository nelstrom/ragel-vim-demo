
desc "Generate a .dot visualization for each .rl file"
task :visualize do
  FileList.new('lib/*.rl').each do |file|
    system "ragel -Vp #{file} > #{file.ext('.dot')}"
  end

end
