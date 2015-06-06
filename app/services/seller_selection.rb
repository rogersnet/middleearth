class SellerSelection

  def self.select_supplier(week,gameboard_id,segment,category)
    #select list of all suppliers for that segment
    sellers = SellerWeekUnitPriceDeclaration.where(:gameboard_id => gameboard_id,
                                                   :week_number  => week,
                                                   :segment      => segment,
                                                   :category     => category ).where('cost > 0' ).order(:cost)
  end
end