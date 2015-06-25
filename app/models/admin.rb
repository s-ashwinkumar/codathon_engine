class Admin < User
  # attr_accessible :title, :body
  has_many :challenges, class_name: "Challenge", foreign_key: "owner_id"

end
