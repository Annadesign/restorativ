class Article < ApplicationRecord
  belongs_to :section

   scope :published, -> { where(ispublished: true).order(id: :desc) }

   scope :ordered, -> { where(ispublished: true, :section_id => '2').order(:position) }

   scope :facts, -> { where(ispublished: true, :section_id => '3').order(:position) }

   mount_uploader :image, ImageUploader

end
