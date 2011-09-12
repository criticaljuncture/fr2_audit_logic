namespace :audit do
  desc "Audit for AGY element that are too large"
  task :agency_element_too_large => :environment do
    AuditProblem::AgencyElementTooLarge.perform
  end

  desc "Audit for missing issues (bulkdata and mods)"
  task :missing_issue => :environment do
    AuditProblem::MissingIssue.perform
  end

  desc "Audit for missing pages"
  task :missing_page_range => :environment do
    AuditProblem::MissingPageRange.perform
  end

  desc "Audit for missing agency names"
  task :missing_agency => :environment do
    AuditProblem::MissingAgency.perform
  end

  desc "Audit for missing agency (but has an agency name)"
  task :missing_agency_name => :environment do
    AuditProblem::MissingAgencyName.perform
  end

  desc "Audit for missing granule class (type)"
  task :missing_granule_class => :environment do
    AuditProblem::MissingGranuleClass.perform
  end

  desc "Audit for missing titles"
  task :missing_title => :environment do
    AuditProblem::MissingTitle.perform
  end

  desc "Run all audit tasks"
  task :all => [
    :agency_element_too_large,
    :missing_mods_file,
    :missing_page_range,
    :missing_agency,
    :missing_agency_name,
    :missing_granule_class,
    :missing_title
  ]
end
