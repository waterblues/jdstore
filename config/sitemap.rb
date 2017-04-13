SitemapGenerator::Sitemap.default_host = "https://desolate-caverns-98949.herokuapp.com/"
SitemapGenerator::Sitemap.create_index = true

# Generate Sitemaps on read only filesystems like Heroku

# pick a place safe to write the files

SitemapGenerator::Sitemap.public_path = 'tmp/'
# store on S3 using CarrierWave

SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
# inform the map cross-linking where to find the other maps

SitemapGenerator::Sitemap.sitemaps_host = "http://#{Setting.aws.bucket}.s3.amazonaws.com/"
# pick a namespace within your bucket to organize your maps

SitemapGenerator::Sitemap.sitemaps_path = 'sitemap/'

SitemapGenerator::Sitemap.create do

  add "/products"

  Product.find_each do |product|
    add product_path(product), :lastmod => product.updated_at
  end

end


  # Put links creation logic here.

  #

  # The root path '/' and sitemap index file are added automatically for you.

  # Links are added to the Sitemap in the order they are specified.

  #

  # Usage: add(path, options={})

  #        (default options are used if you don't specify)

  #

  # Defaults: :priority => 0.5, :changefreq => 'weekly',

  #           :lastmod => Time.now, :host => default_host

  #

  # Examples:

  #

  # Add '/articles'

  #

  #   add articles_path, :priority => 0.7, :changefreq => 'daily'

  #

  # Add all articles:

  #
