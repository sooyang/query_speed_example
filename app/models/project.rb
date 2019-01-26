class Project < ApplicationRecord
  enum status: [ :active, :archived ]

  def self.count_active_projects
    active_projects = Project.where(status: 'active')
    @total_number_of_active_projects = active_projects.size
    @projects_pending_team_lead_approval = active_projects.reject(&:team_lead_action_time).count
    @projects_pending_manager_approval = active_projects.reject(&:manager_action_time).count
  end

  def self.count_active_projects_ar
    active_projects = Project.where(status: 'active')
    @total_number_of_active_projects = active_projects.size
    @projects_pending_team_lead_approval = active_projects.where(team_lead_action_time: nil).size
    @projects_pending_manager_approval = active_projects.where(manager_action_time: nil).size
  end

  def self.count_active_projects_sql
    query = <<~SQL
      SELECT
        SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = 0 AND team_lead_action_time IS null THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = 0 AND manager_action_time IS null THEN 1 ELSE 0 END)
      FROM
        PROJECTS
    SQL

    ActiveRecord::Base.connection.execute(query)
  end

  def self.report
    Benchmark.bmbm do |x|
      x.report("count_active_project") { Project.count_active_projects }
      x.report("count_active_projects_ar") { Project.count_active_projects_ar }
      x.report("count_active_projects_sql") { Project.count_active_projects_sql }
    end
  end
end
