require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList["tests/**/*.rb"]
  t.libs.push 'lib'
end
desc "Run tests"

task default: :test
