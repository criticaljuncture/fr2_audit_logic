namespace :audit do
  desc "Audit for AGY element that are too large"
  task :agency_element_too_large => :environment do
    AuditProblem::AgencyElementTooLarge.perform
  end

  desc "Audit for document numbers starting with X"
  task :invalid_document_number => :environment do
    AuditProblem::InvalidDocumentNumber.perform
  end

  desc "Audit for missing document numbers"
  task :missing_bulkdata_file => :environment do 
    AuditProblem::MissingBulkdataFile.perform
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

  desc "Audit for missing topics"
  task :missing_topic => :environment do
    AuditProblem::MissingTopic.perform
  end

  desc "Run all audit tasks"
  task :all => [
    :agency_element_too_large,
    :invalid_document_number,
    :missing_bulkdata_file,
    :missing_issue,
    :missing_page_range,
    :missing_agency,
    :missing_agency_name,
    :missing_granule_class,
    :missing_title,
    :missing_topic
  ]
end
