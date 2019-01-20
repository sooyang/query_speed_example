class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.integer :status
      t.datetime :team_lead_action_time
      t.datetime :manager_action_time

      t.timestamps
    end
  end
end
