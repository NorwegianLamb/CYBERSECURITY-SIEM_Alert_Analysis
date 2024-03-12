import json

# Load the JSON data from the specified file
file_path = 'data/country_codes.json'

# Load the JSON data from the file
with open(file_path, 'r') as file:
    country_data_json = json.load(file)

# Convert JSON to the PowerShell hashtable format
ps_hashtable_entries = []
for country in country_data_json:
    entry = f"    '{country['name']}' = '{country['alpha-2']}'"
    ps_hashtable_entries.append(entry)

# Join the entries into a single string for output
ps_hashtable_output = "\n".join(ps_hashtable_entries)
print(ps_hashtable_output)
