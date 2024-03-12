import json

file_path = 'data/country_codes.json'

with open(file_path, 'r') as file:
    country_data_json = json.load(file)
ps_hashtable_entries = []
for country in country_data_json:
    entry = f"    '{country['name']}' = '{country['alpha-2']}'"
    ps_hashtable_entries.append(entry)

ps_hashtable_output = "\n".join(ps_hashtable_entries)
print(ps_hashtable_output)
