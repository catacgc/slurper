require 'active_support/core_ext'

# Simple value object for a story
# It's only concern is to store and format yaml data from stories
class YamlStory

  attr_reader :name, :story_type, :requested_by

  def initialize(attributes = {}, defaults = {})
    defaults = defaults.with_indifferent_access
    attributes = attributes.with_indifferent_access

    # delete empty values (otherwise the default_proc bellow won't be called)
    attributes.delete_if { |key, val| val == '' }

    attributes.default_proc = proc do |hash, key|
        defaults[key]
      end

    @name = attributes[:name]
    @description = attributes[:description]
    @story_type = attributes[:story_type]
    @labels = attributes[:labels]
    @requested_by = attributes[:requested_by]
  end

  def labels
    return [] if not @labels
    @labels.split(',').map { |label| label.strip }
  end

  def description
    return nil if @description == nil || @description == ''

    @description.gsub('  ', '').gsub(" \n", "\n")
  end

end