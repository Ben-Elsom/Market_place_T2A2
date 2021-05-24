namespace :task do
    desc "Add words to the logs to check is working"
    task :test => :environment do
        puts "Rake task test"
    end
end


