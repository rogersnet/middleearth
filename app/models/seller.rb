class Seller < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :email

  validates_uniqueness_of :email

  def self.create_from_hash(seller_hash)
    ActiveRecord::Base.transaction do
      new_seller = Seller.new
      new_seller.name  = seller_hash[:name]
      new_seller.email = seller_hash[:email]
      new_seller.phone = seller_hash[:phone]
      new_seller.geo_location = seller_hash[:geo_location]
      new_seller.save!
    end
  end
end
