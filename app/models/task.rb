class Task < ApplicationRecord
	validates :name, presence: true, length: { maximum: 30 }

	validate :validate_name_not_including_comma

	belongs_to :user

	scope :recent, -> { order(created_at: :desc) }

	def self.csv_attributes
		["name", "description", "created_at", "updated_at"]
	end

	def self.ransackable_associations(auth_object = nil)
		[]
	end


	private

    # 名前に「,」を含めないバリデーション
    def validate_name_not_including_comma
    	errors.add(:name, 'にカンマを含めることができません') if name&.include?(',')
    end
end
