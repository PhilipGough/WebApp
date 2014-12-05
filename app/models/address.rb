class Address < ActiveRecord::Base

    belongs_to :user

    validates :user_id, presence: true
    validates :fullname,  presence: true, length: { maximum: 50 }
    validates :lineone,  presence: true, length: { maximum: 50 }
    validates :linetwo,  presence: true, length: { maximum: 50 }
    validates :city,  presence: true, length: { maximum: 20 }
    validates :country,  presence: true, length: { maximum: 50 }
    validates :phone,  presence: true, length: { maximum: 50 }


   def to_s
        result = self.fullname + "\n" +  self.lineone + "\n" + self.linetwo + "\n" + self.city + "\n" + self.country + "\n" + self.phone 
   end
end