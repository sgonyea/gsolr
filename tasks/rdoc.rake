# Rdoc
desc 'Generate documentation for the gsolr gem.'
Rake::RDocTask.new(:doc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = 'GSolr'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end