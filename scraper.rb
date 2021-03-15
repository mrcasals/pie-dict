require_relative "lemma_scraper"

# # Single definition
# LemmaScraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/%C7%B5%CA%B0h%E2%82%82%C3%A9ns")
# # 2 definitions in a single lemma
# LemmaScraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/d%E1%B9%93m")
# # "Reconstruction" section before the definition
# LemmaScraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/h%E2%82%82%C3%A9nts")

# Long etymology, synonims
LemmaScraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/h%E2%82%81%C3%A9%E1%B8%B1wos")
