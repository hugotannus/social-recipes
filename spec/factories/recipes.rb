FactoryGirl.define do
  r = Random.new
  plates = ['sandwich', 'soup', 'pancake', 'pasta', 'cookies']

  factory :recipe do
    title "#{Faker::LordOfTheRings.character}\'s #{plates[r.rand(0...plates.size)]}"
    portions r.rand(1...8)
    prep_time r.rand(2...36) * 5 
    difficulty r.rand(0..2)
    ingredients (0 .. r.rand(3...15)).map {
                  "- #{Faker::Food.measurement} of #{Faker::Food.ingredient}"
                }.join('\n')
    directions Faker::Lorem.paragraph(3, true, 4)
    picture Rack::Test::UploadedFile.new(
              File.open(
                File.join(Rails.root, '/spec/fixtures/images/sample.png')
              )
            )
    cuisine
    kind
    user
  end

end
