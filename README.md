# README

Simple project to simulate the speed of querying and counting.

## Steps to setup project

- `git clone` this project
- `bundle install`
- Enter `rails c`
- Seed the data for example `1000.times {Project.new(status: [0,1].sample, team_lead_action_time: [Time.current, nil].sample, manager_action_time: [Time.current, nil].sample).save}`
- Run the following methods to get the benchmark value `Project.count_active_projects` and `Project.count_active_projects_ar` and `Project.count_active_projects_sql`
