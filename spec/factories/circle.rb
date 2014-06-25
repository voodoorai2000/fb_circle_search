FactoryGirl.define do
  factory :circle do
    name Faker::Company.name
    kind %w(group page user).sample

    trait :recent do
      revised false
    end
    trait :revised do
      revised true
    end

    trait :group do
      kind 'group'
    end
    trait :page do
      kind 'page'
    end
    trait :user do
      kind 'user'
    end

  end
end
