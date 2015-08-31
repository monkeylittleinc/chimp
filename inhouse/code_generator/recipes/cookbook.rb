context = ChefDK::Generator.context
cookbook_dir = File.join(context.cookbook_root, context.cookbook_name)
attribute_context = context.cookbook_name.gsub(/-/, '_')

# Create cookbook directories
cookbook_directories = [
  'attributes',
  'recipes',
  'templates/default',
  'files/default',
  'test/integration',
  'test/fixtures/cookbooks',
  'shared/data',
  'shared/support'
]
cookbook_directories.each do |dir|
  directory File.join(cookbook_dir, dir) do
    recursive true
  end
end

# Create basic files
files_basic = %w(
  .gitignore
  .rubocop.yml
  chefignore
  Rakefile
  Berksfile
  Gemfile
)
files_basic.each do |file|
  cookbook_file File.join(cookbook_dir, file) do
    action :create_if_missing
  end
end

# Create basic files from template
files_template = %w(
  metadata.rb
  README.md
  ISSUES.md
  CHANGELOG.md
  LICENSE
)
files_template.each do |file|
  template File.join(cookbook_dir, file) do
    helpers(ChefDK::Generator::TemplateHelper)
    action :create_if_missing
  end
end

# Create more complex files from templates
template "#{cookbook_dir}/attributes/default.rb" do
  source 'default_attributes.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
  variables(
    attribute_context: attribute_context
  )
end
template "#{cookbook_dir}/recipes/default.rb" do
  source 'default_recipe.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# git
if context.have_git
  unless context.skip_git_init

    execute('initialize-git') do
      command('git init .')
      cwd cookbook_dir
    end
  end

  cookbook_file "#{cookbook_dir}/.gitignore" do
    source '.gitignore'
  end
end
