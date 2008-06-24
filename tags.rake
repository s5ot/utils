# http://d.hatena.ne.jp/moro/20060515/1147704687
# vim:set ft=ruby:

GEM_ROOT = "/usr/lib/ruby/gems/1.8/gems"
desc "Generate `tags' file using exuberant-ctags."
namespace :utils do
  task(:tags) do
    command     = "ctags --append --recurse ".freeze
    File.exist?("#{RAILS_ROOT}/tags") && File.delete("#{RAILS_ROOT}/tags")

    unless File.directory? "#{RAILS_ROOT}/vendor/rails"
      rails_dir = current_gems.map{|path| "#{GEM_ROOT}/#{path}" }
    else
      rails_dir = ["#{RAILS_ROOT}/vendor/rails"]
    end

    (app_dirs + rails_dir).each do |path|
      $stderr.puts "Generating tags for #{path}."
      system "#{command} #{path}" || raise("Failed to generate tags.")
    end
  end
end

def app_dirs
  %w[ app
      lib
      components
      test].freeze
end

def current_gems
  %w[ actionmailer-1.3.5
      actionpack-1.13.5
      actionwebservice-1.2.5
      activerecord-1.15.5
      activesupport-1.4.4
      rails-1.2.5 ].freeze
end
private :app_dirs, :current_gems
