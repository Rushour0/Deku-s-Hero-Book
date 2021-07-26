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
chrome_options.add_argument("--log-level=3")

# Starting the chromedriver program
driver = webdriver.Chrome(options = chrome_options)
print("Started")

# Basic Site
basic_site = "https://myheroacademia.fandom.com"

# Extension Site
extension_sites = ["/wiki/Category:Pro_Heroes","/wiki/Category:U.A._Staff","/wiki/Category:U.A._Students","/wiki/Category:Villains","/wiki/Category:Vigilantes"]

links = {}

for extension_site in extension_sites:
	# Site to be interacted with
	site = basic_site + extension_site

	# Accessing the site
	driver.get(site)

	# Getting the source code of the site
	content = driver.page_source

	# Using the scraping tool
	soup = BeautifulSoup(content,features="html.parser")

	# Category name
	category = extension_site.split(':')[1]
	links[category] = [basic_site + a["href"] for a in soup.findAll('a',href=True, attrs={'class':'category-page__member-link'}) if a["href"][:14] != "/wiki/Category"]

	with open(f"LinksToCharacters{category}.txt", "w") as file:
		file.write('\n'.join(links[category]))

information = {}
information["Raw"] = {}
information["Complete Information"] = {}

not_found = set()

for characterType,links_to_characters in links.items():

	information["Raw"][characterType] = {}
	information["Complete Information"][characterType] = {}

	for link in links_to_characters:
		
		temp = link.split("/")[-1].replace('_',' ')
		print(temp)

		# Accessing the site
		driver.get(link)

		# Getting the source code of the site
		content = driver.page_source

		# Using the scraping tool
		soup = BeautifulSoup(content,features="html.parser")

		# Attributes of a character
		attributes = ["romaji","alias","birthday","gender","height","quirk","image"]

		# Character attributes
		name,alias,birthday,gender,height,quirk,image = [None]*7

		# Checking if all info is available
		flag = 1

		# Get all attributes
		for attribute in attributes:

			# A default format to extract the text
			the_parent = soup.find('div',attrs = {"class":"pi-item pi-data pi-item-spacing pi-border-color","data-source":attribute})
			
			# Default value
			value = None

			try:
			
				# The value as per the attribute
				if attribute == "romaji":
					value = the_parent.div.i.text
					name = value

					information["Raw"][characterType][name] = {}
					information["Raw"][characterType][name]["Real Name"] = name
				
				elif attribute == "alias":
					value = the_parent.div.text
					
					try:
						value = value.split("(")[0]

					except:
						pass
					alias = value

				elif attribute == "birthday":
					the_parent.div.find(text = True)
					value = the_parent.div.find(text = True)
					birthday = value

				elif attribute == "gender":
					the_parent.div.find(text = True)
					value = the_parent.div.find(text = True)
					gender = value

				elif attribute == "height":
					the_parent.div.find(text = True)
					value = the_parent.div.find(text = True)
					height = value

				elif attribute == "quirk":
					the_parent.div.find(text = True)
					value = the_parent.div.find(text = True)
					quirk = value

				else:
					image = soup.find('div', attrs = {'class':'wds-tab__content wds-is-current'}).find('figure').find('img')["src"]
					value = image

			except:
				flag = 0

				# Making up for not finding real name / romaji name
				if attribute == "romaji":

					information["Raw"][characterType][temp] = {}
					information["Raw"][characterType][temp]["Real Name"] = name
					name = temp


				# Making up for not finding alias
				if attribute == "alias":
					value = temp

				print(f"{attribute} not found")
				not_found.add(temp)

			#print(attribute,":",value)
			if attribute != "romaji":
				information["Raw"][characterType][name][attribute.capitalize()] = value
		if flag :
			information["Complete Information"][characterType][name] = {}
			information["Complete Information"][characterType][name]["Real Name"] = name
			information["Complete Information"][characterType][name]["Alias"] = alias
			information["Complete Information"][characterType][name]["Birthday"] = birthday
			information["Complete Information"][characterType][name]["Gender"] = gender
			information["Complete Information"][characterType][name]["Height"] = height
			information["Complete Information"][characterType][name]["Quirk"] = quirk
			information["Complete Information"][characterType][name]["Image"] = image


driver.quit()


# Converting the information into .json format
json_file = json.dumps( information, indent = 4 )

with open("Hero Book.json", "w") as file:
	file.write(json_file)
