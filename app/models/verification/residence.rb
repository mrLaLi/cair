class Verification::Residence
  include ActiveModel::Model
  include ActiveModel::Dates
  include ActiveRecord::AttributeAssignment


  attr_accessor :user, :document_number, :document_type, :date_of_birth, :postal_code, :image, :terms_of_service

  validates :document_number, presence: true
  validates :document_type, presence: true
  validates :date_of_birth, presence: true
  validates :postal_code, presence: true
  validates :image, presence: true
  validates :terms_of_service, acceptance: { allow_nil: false }

  validate :allowed_age
  validate :document_number_uniqueness

  validate :local_postal_code

  def initialize(attrs = {})
    self.date_of_birth = parse_date("date_of_birth", attrs)
    attrs = remove_date("date_of_birth", attrs)
    super
    clean_document_number
  end



  def save

    return false unless valid?
    
    user.take_votes_if_erased_document(document_number, document_type)

    user.update(document_number:       document_number,
                document_type:         document_type,
              
                date_of_birth:         date_of_birth,
                image:                 image,
                residence_verified_at: Time.current)
  end

  def save!
    validate! && save
  end

  def allowed_age
    return if errors[:date_of_birth].any? || Age.in_years(date_of_birth) >= User.minimum_required_age

    errors.add(:date_of_birth, I18n.t("verification.residence.new.error_not_allowed_age"))
  end

  def document_number_uniqueness
    errors.add(:document_number, I18n.t("errors.messages.taken")) if User.active.where(document_number: document_number).any?
  end

  def local_postal_code
    errors.add(:postal_code, I18n.t("verification.residence.new.error_not_allowed_postal_code")) unless valid_postal_code?
  end

  def clean_document_number
    self.document_number = document_number.gsub(/[^a-z0-9]+/i, "").upcase if document_number.present?
  end

  
  def valid_postal_code?
    return true if Setting["postal_codes"].blank?

    Setting["postal_codes"].split(",").any? do |code_or_range|
      if code_or_range.include?(":")
        Range.new(*code_or_range.split(":").map(&:strip)).include?(postal_code&.strip)
      else
        /\A#{code_or_range.strip}\Z/.match?(postal_code&.strip)
      end
    end
  end
end