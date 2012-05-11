require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User", :email => "example@railstutorial.org", :password => "foobar", :password_confirmation => "foobar")
    frank = User.create!(:name => "Frank Smieja", :email => "franksmieja@gmail.com", :password => "frankie", :password_confirmation => "frankie")
    admin.toggle!(:admin)
    frank.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name, :email => email, :password => password, :password_confirmation => password)
    end
    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end   
    end

    30.times do |n|
      title = Faker::Lorem.words(3)
      summary = Faker::Lorem.paragraph(3)
      content = Faker::Lorem.paragraphs(3)
      date = "05/#{n+1}/2012"
      Event.create!(:title => title, :summary => summary, :content => content, :date => date)
    end
  end
end
