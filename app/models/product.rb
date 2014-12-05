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
  validates :quantity,  presence: true , numericality: { greater_than_or_equal_to: 0 }


def self.search(search)
  
   where("title like ? OR description LIKE ?" , "%#{search}%",  "%#{search}%") 

end

def item_sold
   # binding.pry
    self.quantity = (self.quantity - 1 )
    self.save
end  


def cart_action(current_user_id)
  if $redis.sismember "cart#{current_user_id}", id
    "Remove from"
  else
    "Add to"
  end
end

end