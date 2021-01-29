FactoryBot.define do
  factory :book do
    title {Faker::Lorem.sentence}
    story {Faker::Lorem.sentence}
    impression {Faker::Lorem.sentence}
    association :user 

    after(:build) do |book|
      book.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
