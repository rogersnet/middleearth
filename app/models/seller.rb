class Seller < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :email

  validates_uniqueness_of :email

  def self.create_from_hash(seller_hash)
    puts "#{seller_hash.inspect}"
    ActiveRecord::Base.transaction do
      new_seller = Seller.new(:name  => seller_hash[:name],
                              :email => seller_hash[:email],
                              :phone => seller_hash[:phone],
                              :geo_location => seller_hash[:geo_location],
                              :password => seller_hash[:password])
      new_seller.save!
    end
  end

end
