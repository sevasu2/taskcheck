class Task < ApplicationRecord
    validates :name, presence: true, length: { maximum: 30 }

    validate :validate_name_not_including_comma


    private

    # 名前に「,」を含めないバリデーション
    def validate_name_not_including_comma
        errors.add(:name, 'にカンマを含めることができません') if name&.include?(',')
    end
end
