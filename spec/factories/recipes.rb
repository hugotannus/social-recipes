FactoryGirl.define do
  r = Random.new

  factory :recipe do
    sequence(:title) { |n| format('Receita %02d', n) }
    portions { r.rand(1...8) }
    prep_time { r.rand(2...36) * 5 }
    difficulty { r.rand(0..2) }
    ingredients { generate_ingredientes }
    directions { Faker::Lorem.paragraph(3, true, 4) }
    picture { set_picture }
    cuisine
    kind
    user
  end
end

def generate_ingredientes
  r = Random.new
  (0..r.rand(3...15)).map do
    "- #{Faker::Food.measurement} of #{Faker::Food.ingredient}"
  end.join('\n')
end

def set_picture
  Rack::Test::UploadedFile.new(
    File.open(File.join(Rails.root, '/spec/fixtures/images/sample.png'))
  )
end
