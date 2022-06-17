profile_text = ["アクション","映画","洋画",",アメコミ","マーベル","ディズニー","恋愛系","どんなジャンルでも","サスペンス","ハリウッド"]
10.times do |n|
  user = User.create!(
    username: Faker::JapaneseMedia::StudioGhibli.character,
    email: Faker::Internet.email,
    password: "foobar",
    profile: "#{profile_text[n]}の映画が好きです。",
    role: ((n == 0) ? "admin" : "user")
  )
  puts "\"#{user.username}\" has created!"
end
