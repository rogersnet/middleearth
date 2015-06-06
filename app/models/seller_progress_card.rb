class SellerProgressCard < ActiveRecord::Base

  def self.update_balance(balance_hash)
    seller_id = balance_hash[:seller_id]
    unless Seller.exists?(:id => seller_id)
      return MeResponse.new(400,'Invalid Seller',nil)
    end

    response = nil
    begin
      spc = SellerProgressCard.where(:seller_id => seller_id, :gameboard_id => balance_hash[:gameboard_id])
      if spc.nil?
        spc = SellerProgressCard.new
        spc.seller_id = seller_id
        spc.gameboard_id = balance_hash[:gameboard_id]
        spc.save!
        spc = spc.reload
      end
      spc.update_attributes(:current_balance => balance_hash[:balance])
      response = MeResponse.new(200,'Balance successfully updated',nil)
    rescue => e
      response = MeResponse.new(400,e.message,e.backtrace)
    end
    response
  end
end
