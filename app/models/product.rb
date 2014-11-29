class Product < ActiveRecord::Base
 
  validates :avatar,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 5.megabytes }

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates :title,  presence: true, length: { maximum: 50 }
  validates :description,  presence: true, length: { maximum: 150 }
  validates :price,  presence: true , numericality: { greater_than_or_equal_to: 1 }
  validates :quantity,  presence: true , numericality: { greater_than_or_equal_to: 1 }
end


