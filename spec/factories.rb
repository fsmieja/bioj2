# by using the symbol ':user', we get Factory girl to simulate the User model
Factory.define :user do |user|
  user.name                   "Michael Hartl"
  user.email                  "mhartl@example.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end

Factory.define :event do |event|
  event.content "Foo bar"
  event.title  "Foo bar"
  event.summary  "Foo bar"
  event.date  1.day.ago
end
