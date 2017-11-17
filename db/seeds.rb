require 'support/factories'

[User, Tag, Article].map(&:delete_all)

10.times { FactoryBot.create(:user) }

50.times do
  FactoryBot.create(:article,
    user: User.all.sample
  )
end

10.times do
  FactoryBot.create(:project)
end
