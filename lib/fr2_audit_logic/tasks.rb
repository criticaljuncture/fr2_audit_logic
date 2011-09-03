namespace :audit do
  desc "Audit for AGY element that are too large"
  task :agency_element_too_large => :environment do
    AuditProblem::AgencyElementTooLarge.perform
  end

  desc "Audit for missing MODS files"
  task :missing_mods_file => :environment do
    AuditProblem::MissingModsFile.perform
  end

  desc "Audit for missing pages"
  task :missing_page_range => :environment do
    AuditProblem::MissingPageRange.perform
  end

  desc "Audit for missing titles"
  task :missing_title => :environment do
    AuditProblem::MissingTitle.perform
  end

  desc "Run all audit tasks"
  task :all => [:agency_element_too_large, :missing_mods_file, :missing_page_range, :missing_title]
end
