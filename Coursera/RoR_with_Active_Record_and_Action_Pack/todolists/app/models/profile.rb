class Profile < ActiveRecord::Base
  belongs_to :user
  validates :gender, inclusion: {in: ['male', 'female']}
  validate :name_and_lastname_not_null
  validate :male_cant_be_sue

  def name_and_lastname_not_null
    if first_name.blank? && last_name.blank?
      errors.add(:first_name, "Can't be blank")
      errors.add(:last_name, "Can't be blank")
    end
  end

  def male_cant_be_sue
    if gender == 'male' and first_name == 'Sue'
      errors.add(:name, "Males don't have name Sue")
    end
  end

  def self.get_all_profiles(min, max)
    Profile.where('birth_year between ? and ?', min, max).order(:birth_year)
  end
end
