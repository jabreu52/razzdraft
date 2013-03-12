class BaseballTeam
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :user
  has_many :baseball_projections

  after_validation :auto_name

  field :name, type: String
  field :league_type, type: String
  field :league_size, type: Integer

  field :catchers, type: Array, default: ->{ [] }
  field :first_basemen, type: Array, default: ->{ [] }
  field :second_basemen, type: Array, default: ->{ [] }
  field :shortstops, type: Array, default: ->{ [] }
  field :third_basemen, type: Array, default: ->{ [] }
	field :outfielders, type: Array, default: ->{ [] }
	field :utility_men, type: Array, default: ->{ [] }
	field :designated_hitters, type: Array, default: ->{ [] }
  field :middle_infielders, type: Array, default: ->{ [] }
  field :corner_infielders, type: Array, default: ->{ [] }
	field :starting_pitchers, type: Array, default: ->{ [] }
	field :relief_pitchers, type: Array, default: ->{ [] }
  field :pitchers, type: Array, default: ->{ [] }
  field :bench, type: Array, default: ->{ [] }
  field :batting_bench, type: Array, default: ->{ [] }
  field :pitching_bench, type: Array, default: ->{ [] }

  field :catchers_max, type: Integer
  field :first_basemen_max, type: Integer
  field :second_basemen_max, type: Integer
  field :shortstops_max, type: Integer
  field :third_basemen_max, type: Integer
  field :outfielders_max, type: Integer
  field :utility_men_max, type: Integer
  field :designated_hitters_max, type: Integer
  field :middle_infielders_max, type: Integer
  field :corner_infielders_max, type: Integer
  field :starting_pitchers_max, type: Integer
  field :relief_pitchers_max, type: Integer
  field :pitchers_max, type: Integer
  field :bench_max, type: Integer

  field :plate_appearances, type: Integer, default: ->{ 0 }
  field :at_bats, type: Integer, default: ->{ 0 }
  field :hits, type: Integer, default: ->{ 0 }
  field :times_on_base, type: Integer, default: ->{ 0 }
  field :r, type: Integer, default: ->{ 0 }
  field :hr, type: Integer, default: ->{ 0 }
  field :rbi, type: Integer, default: ->{ 0 }
  field :sb, type: Integer, default: ->{ 0 }
  field :avg, type: Float, default: ->{ 0.000 }
  field :obp, type: Float, default: ->{ 0.000 }

  field :innings_pitched, type: Integer, default: ->{ 0 }
  field :earned_runs, type: Float, default: ->{ 0.000 }
  field :basemen_allowed, type: Float, default: ->{ 0.000 }
  field :w, type: Integer, default: ->{ 0 }
  field :l, type: Integer, default: ->{ 0 }
  field :era, type: Float, default: ->{ 0.00 }
  field :whip, type: Float, default: ->{ 0.00 }
  field :k, type: Integer, default: ->{ 0 }
  field :sv, type: Integer, default: ->{ 0 }

  def auto_name
    self.name = "Team #{self.user.baseball_teams.length}"
  end

  %W[ catchers first_basemen second_basemen shortstops third_basemen outfielders utility_men designated_hitters middle_infielders corner_infielders starting_pitchers relief_pitchers pitchers bench batting_bench pitching_bench].each do |position|
    define_method "drafted_#{position}" do |*args|
      BaseballProjection.in(_id: self.send(position))
    end
  end

end
