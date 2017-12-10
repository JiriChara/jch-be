FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { Faker::Lorem.word }
  end

  factory :article do
    user
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph(50) }
    published_at { Time.now }
    after(:create) do |article|
      article.tag_list = (1..(1..5).to_a.sample).map do
        Faker::Lorem.word
      end.join(',')
    end
    type 'Article'
  end

  factory :tag do
    name { Faker::Lorem.word }
  end

  factory :project do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(20) }
    url { Faker::Internet.url }
    published_at { Time.now }
  end
end
