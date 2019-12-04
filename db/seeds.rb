# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Add a seed user in development environment only
if :development
  @user = User.new({
    firstname: 'admin',
    lastname: 'admin',
    mail: 'admin@isska.ch',
    password: 'admin12',
    password_confirmation: 'admin12'
  })

  @user.gen_token_and_salt
  if @user.save
    puts 'seed ok'
  else
    puts 'error'
  end
end