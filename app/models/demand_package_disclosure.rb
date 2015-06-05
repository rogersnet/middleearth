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
end
