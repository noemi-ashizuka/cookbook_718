require 'open-uri'
require 'nokogiri'
require_relative 'recipe'

class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@keyword}"

    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.card__detailsContainer').first(5).map do |card|
      name = card.search('.card__title').text.strip
      description = card.search('.card__summary').text.strip
      rating = card.search('.rating-star.active').count
      url = card.search('.card__titleLink').attribute('href').value
      prep_time = fetch_prep_time(url)
      Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time)
    end
  end

  def fetch_prep_time(url)
    html = URI.open(url).read
    doc = Nokogiri::HTML(html)
    doc.search('.recipe-meta-item-body').first.text.strip
  end
end

# scraper = ScrapeAllrecipesService.new('banana')
# p scraper.call
