# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

if Category.count.zero?
  categories = ['Personal items', 'Transport', 'Work', 'For home', 'Property', 'Hobby', 'Electronics', 'Animals', 'Some']
  categories.each { |category| Category.create(name: category) }
end

if User.count.zero?
  admin = User.create(
    email: 'asmolko@yandex.ru',
    name: 'Anton Smolko',
    admin: true
  )
  admin.save!

  user = User.create(
    email: 'sarah@conor.com',
    name: 'Sarah Conor'
  )
  user.save!
end

user = User.first

if Bulletin.count.zero?
  10.times do |i|
    bulletin = Bulletin.new(
      title: Faker::Movies::VForVendetta.character,
      description: Faker::Lorem.paragraph(sentence_count: 5),
      category_id: Category.all.sample.id,
      user_id: user.id
    )
    filename = "image-#{i + 1}.jpeg"
    filepath = Rails.root.join('test/fixtures/files', filename)
    bulletin.image.attach(
      io: File.open(filepath),
      filename: filename,
      content_type: 'application/jpeg'
    )
    bulletin.save!
  end
end
