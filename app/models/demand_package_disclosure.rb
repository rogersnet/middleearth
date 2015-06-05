class DemandPackageDisclosure < ActiveRecord::Base

  has_many :demand_package_disclosure_segments
  has_many :demand_package_disclosure_categories

  def self.fetch_demand_package_by_id(dp_id)
    return nil unless DemandPackageDisclosure.exists?(:id => dp_id)

    response = {}
    dpd = DemandPackageDisclosure.find(dp_id)
    response.total_demand_estimate = dpd.total_demand_estimate
    response.segment_demands = []
    dpd.demand_package_disclosure_segments.each do |seg|
      response.segment_demands << {:segment => seg.segment, :demand_size => seg.demand_size}
    end
    response
  end

  def self.fetch_actual_demand(week_number,gameboard_id)
    demand_package_id = GameboardWeekMap.where(:gameboard_id => gameboard_id,:week_number => week_number).select(:demand_package_disclosure_id).first

    self.joins(:demand_package_disclosure_categories)
        .where(:id => demand_package_id)
         .select(DemandPackageDisclosureCategory.arel_table[:quantity])
         .select(DemandPackageDisclosureCategory.arel_table[:segment])
         .select(DemandPackageDisclosureCategory.arel_table[:category])
  end
end
