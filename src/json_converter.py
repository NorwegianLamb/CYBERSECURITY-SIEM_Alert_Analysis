"""
Author: Flavio Gjoni
Status: DONE (?)
Description: If you're encountering "ConstrainedLanguage" problems with the powershell script,
you might not be able to load the csv/json files so you might want to add the countries "manually"
"""
import json

file_path = 'data/country_codes.json'
with open(file_path, 'r') as file:
    country_data_json = json.load(file)

# Convert JSON to PowerShell hashtable format
ps_hashtable_lines = []
for country in country_data_json:
    line = "@{ \"name\" = \"" + country["name"] + "\"; \"alpha-2\" = \"" + country["alpha-2"] + "\"; \"country-code\" = \"" + country["country-code"] + "\" },"
    ps_hashtable_lines.append(line)

ps_hashtable_output = "\n".join(ps_hashtable_lines)
print(ps_hashtable_output)