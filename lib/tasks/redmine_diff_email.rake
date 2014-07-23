namespace :redmine_diff_email do

  desc "Show library version"
  task :version do
    puts "Redmine Diff Email #{version("plugins/redmine_diff_email/init.rb")}"
  end


  desc "Start unit tests"
  task :test => :default
  task :default do
    RSpec::Core::RakeTask.new(:spec) do |config|
      config.rspec_opts = "plugins/redmine_diff_email/spec --color --format nested --fail-fast"
    end
    Rake::Task["spec"].invoke
  end


  desc "Start unit tests in JUnit format"
  task :test_junit do
    RSpec::Core::RakeTask.new(:spec) do |config|
      config.rspec_opts = "plugins/redmine_diff_email/spec --format RspecJunitFormatter --out junit/rspec.xml"
    end
    Rake::Task["spec"].invoke
  end


  def version(path)
    line = File.read(Rails.root.join(path))[/^\s*version\s*.*/]
    line.match(/.*version\s*['"](.*)['"]/)[1]
  end

end
