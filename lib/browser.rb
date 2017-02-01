require "open-uri"
require "nokogiri"
# html_file = File.read("/Users/sergiorivas/code/sergio-rivas/
# fullstack-challenges/02-OOP/04-Cookbook-Day-Two/01-Cookbook-Advanced/lib/strawberry.html")
# html_doc = Nokogiri::HTML(html_file)
class Browser
  def html_doc_set(ingredient)
    html_docs = []
    main_url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}"
    html_doc = conversion(main_url)
    html_docs << html_doc
    i = calculate_pages(html_doc).to_i
    additional_pages(i, ingredient).each do |url|
      html_docs << conversion(url)
    end
    return html_docs
  end

  def conversion(url)
    html_file = open(url)
    html_doc = Nokogiri::HTML(html_file)
    html_doc
  end

  def fetch_recipes(html_docs)
    recipes = []
    html_docs.each { |html_doc| recipes += html_doc.search("div.m_titre_resultat") }
    recipes
  end

  def fetch_descriptions(html_docs)
    descriptions = []
    html_docs.each { |html_doc| descriptions.push(*html_doc.search("div.m_texte_resultat")) }
    descriptions
  end

  def calculate_cookingtimes(html_docs)
    #html_doc.css('script').remove
    noko_array = []
    cooking_times = []
    html_docs.each { |html_doc| noko_array.push(*html_doc.search("div.m_detail_time")) }
    noko_array.each { |element| cooking_times << eval(element.children.text.gsub(/\W/, "").gsub(/h/,"*60+").gsub(/min/, "+").chop) }
    cooking_times
  end

  def calculate_pages(html_doc)
    edit_doc = html_doc
    edit_doc.css('span').remove
    total_recipes = html_doc.search("div.m_resultats_recherche_titre").text.strip.gsub(/^(.+)-\s10\s\/\s/, "").to_i
    total_recipes / 10
  end

  def additional_pages(page_total, ingredient)
    urls = []
    (1..page_total).each do |i|
      url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}&start=#{i}0"
      urls << url
    end
    return urls
  end
end
# browser = Browser.new
# browser.calculate_cookingtimes(html_doc)
