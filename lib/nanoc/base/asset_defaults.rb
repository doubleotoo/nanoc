module Nanoc

  # Nanoc::AssetDefaults represent the default attributes for all assets in
  # the site. If a specific asset attribute is requested, but not found, then
  # the asset defaults will be queried for this attribute. (If the attribute
  # doesn't even exist in the asset defaults, hardcoded defaults will be
  # used.)
  class AssetDefaults

    # Nanoc::Site this set of asset defaults belongs to.
    attr_accessor :site

    # A hash containing the default asset attributes.
    attr_reader :attributes

    # The time when this set of asset defaults was last modified.
    attr_reader :mtime

    # Creates a new set of asset defaults.
    #
    # +attributes+:: The hash containing the metadata that individual assets
    #                will override.
    #
    # +mtime+:: The time when the asset defaults were last modified
    #           (optional).
    def initialize(attributes, mtime=nil)
      @attributes = attributes.clean
      @mtime      = mtime
    end

    # Saves the asset defaults in the database, creating it if it doesn't
    # exist yet or updating it if it already exists. Tells the site's data
    # source to save the asset defaults.
    def save
      @site.data_source.loading do
        @site.data_source.save_asset_defaults(self)
      end
    end

  end

end