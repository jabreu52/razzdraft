class BaseballProjection
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :baseball_team

  after_validation :fix_blurb
  after_update :update_rank

  def fix_blurb
    self.blurb = blurb.gsub(/<a href/, "<a target='_blank' href").gsub(/_/," ").gsub(/Ð/, " ").gsub(/Ó/,"'").gsub(/&lt;/, "<").gsub(/&lt;/, "<").gsub(/&gt;/, ">") if self.blurb
  end

  def update_rank
    if rank > rank_was
      BaseballProjection.gte(rank: rank_was).ne(_id: id).inc(:rank, -1)
      BaseballProjection.gte(rank: rank).ne(_id: id).inc(:rank, 1)
    else
      BaseballProjection.lte(rank: rank_was).ne(_id: id).inc(:rank, 1)
      BaseballProjection.lte(rank: rank).ne(_id: id).inc(:rank, -1)
    end
  end

  field :steamer_id, type: String
  field :name, type: String
  field :team, type: String
	field :rank, type: Integer

  field :espn_positions, type: Array
  field :yahoo_positions, type: Array

  field :r, type: Integer
  field :hr, type: Integer
  field :rbi, type: Integer
  field :sb, type: Integer
  field :avg, type: Float
  field :obp, type: Float

  field :w, type: Integer
  field :l, type: Integer
  field :k, type: Integer
  field :sv, type: Integer
  field :era, type: Float
  field :whip, type: Float

  field :batter, type: Boolean
  field :blurb, type: String
  field :year, type: Integer
  field :owner, type: String

  def avg_fixed
    ("%0.3f" % avg).sub!(/^0/, "")
  end
  def obp_fixed
    ("%0.3f" % obp).sub!(/^0/, "")
  end
  def era_fixed
    "%0.2f" % era
  end
  def whip_fixed
    "%0.2f" % whip
  end
end
