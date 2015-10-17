class Commit
  include Mongoid::Document
  include Mongoid::Timestamps

  field :message, type: String
  field :commit_date, type: DateTime
  field :html_url, type: String

  belongs_to :member
  belongs_to :repository
  belongs_to :team

  has_many :scores, as: :scorable

  validates :message, uniqueness: {:scope => :commit_date}

  def self.get_data(category, start_date, end_date)
    last_commit = Commit.order(created_at: :asc).last

    title = last_commit.present? ? "Code Curiosity Stats (Last Updated: #{last_commit.created_at.strftime("%D %r")})" : "No Data"
    c_objects = category == "Team" ? Team.all.order(name: :asc) : Member.team_members.order(username: :asc)

    data = c_objects.map do |obj|
      commit_count = obj.commits.where(:commit_date.gte => start_date, :commit_date.lte => end_date).count
      {name: (obj.is_a? Team) ? obj.name : obj.username, y: commit_count}
    end

    return data.to_json, title
  end

  def user_score(user)
    scores.where(user: user).first.try(:rank)
  end
end
