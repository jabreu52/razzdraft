require 'csv'
puts "ADMIN USER"
AdminUser.create name: "Jamil Abreu", email: 'abreu.jamil@gmail.com', password: 'password', password_confirmation: 'password'

puts "CREATE USERS"
20.times do
  random_uid = rand(300000..302715)
  User.create(
    name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    email: Faker::Internet.email,
    password: "password",
    description: Faker::Lorem.paragraph
  )
end

puts "CREATE PROJECTIONS"
CSV.foreach("#{Rails.root}/lib/data/baseball.csv", encoding: "ISO8859-1:utf-8", headers: true) do |row|
	# player = BaseballPlayer.create()
	BaseballProjection.create(
		steamer_id: row[0],
		name: row[1],
		team: row[2],
		espn_positions: row[3].split(","),
		yahoo_positions: row[4].split(","),
		rank: row[5],
		r: row[8],
		hr: row[9],
		rbi: row[10],
		sb: row[11],
		avg: row[12],
		obp: row[13],
		w: row[17],
		l: row[18],
		k: row[21],
		sv: row[22],
		era: row[19],
		whip: row[20],
		batter: row[8].blank? ? false : true,
		blurb: row[25],
		year: 2013,
		owner: "Grey Albright"
	)
end