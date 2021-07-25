# For scraping
from bs4 import BeautifulSoup

# For storage into .csv files
import pandas as pd

# For storage into .json files
import json

# For interaction with the internet
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
print("Imported")

# Options for Google Chrome
chrome_options = Options()

# Setting up the chromedriver to interact with the internet (Headless format)
chrome_options.add_argument("--headless")

# Starting the chromedriver program
driver = webdriver.Chrome(options = chrome_options)
print("Started")

# Basic Site
basic_site = "https://myheroacademia.fandom.com"

# Extension Site
extension_site = ["/wiki/Category:Pro_Heroes"]

# Site to be interacted with
site = basic_site + extension_site[0]

# Accessing the site
driver.get(site)

# Getting the source code of the site
content = driver.page_source

# Using the scraping tool
soup = BeautifulSoup(content)

links = [a["href"] for a in soup.findAll('a',href=True, attrs={'class':'category-page__member-link'}) if a["href"][:14] != "/wiki/Category"]

with open("LinksToCharacters.txt", "w") as file:
	file.write(basic_site + f'\n{basic_site}'.join(links))



driver.quit()