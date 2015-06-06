class GameboardWeekMap < ActiveRecord::Base

  belongs_to :gameboard

  def self.table
    self.arel_table
  end

  def self.create_new_week(week_hash)
    gameboard_id = week_hash[:gameboard_id]
    unless Gameboard.exists?(:id => gameboard_id)
      return MeResponse.new(400,'Non existent game board id',nil)
    end

    response = nil
    begin
      ActiveRecord::Base.transaction do
        pgbw = GameboardWeekMap.where(:gameboard_id => gameboard_id).order('id DESC').first
        unless pgbw.nil?
          pgbw.update_attributes(:end_time => Time.now, :status => 'COMPLETED')
        end

        gbw = GameboardWeekMap.new
        gbw.gameboard_id = gameboard_id
        gbw.week_number  = (GameboardWeekMap.where(:gameboard_id => gameboard_id).maximum(:week_number) || 0 ) + 1
        gbw.start_time   = Time.now
        gbw.status       = 'IN_PROGRESS'
        gbw.demand_package_disclosure_id = DemandPackageDisclosure.find_unassigned(gameboard_id)
        gbw.save!
      end
      response = MeResponse.new(200,'New Week successfully created',nil)
    rescue => e
      response = MeResponse.new(400,e.message,e.backtrace)
    end
    response
  end
end
