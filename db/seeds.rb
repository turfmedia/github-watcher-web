# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
projects = ['Project1', 'Project2', 'Project3',
            'Project4', 'Project5']

projects.each_with_index do |project, index|
  Project.create(name: project, user_id: index+1 )
end

topics = {'Topic1'=>'RUBY','Topic2'=>'JAVA','Topic3'=>'HTML','Topic4'=>'HTML','Topic5'=>'CSS'}

topics.each_with_index do |item, index|
  SearchItem.create(topic: item[0], language:item[1], project_id: index+1)
end