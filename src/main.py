"""
Author: Flavio Gjoni
Status: IN-PROGRESS
Description: This python project will be a translation of the main.ps1 powershell script, 
which parses a CSV containing cybersecurity alerts and matches them with users' properties retrieved from ADUC
"""
import pandas as pd

def load_csv(file_path):
    try:
        df = pd.read_csv(file_path, header=1, sep=';')
        return df
    except FileNotFoundError:
        print(f"File '{file_path}' not found")
        return None
    except Exception as e:
        print(f"Error loading CSV file: {e}")
        return None

def process_data(df):
    print(df.shape)
    print(df.head())

def main():
    csv_file = '../alerts.csv' # use 'data/alerts.csv' for your project
    df = load_csv(csv_file)
    if df is None:
        return
    process_data(df)


if __name__ == '__main__':
    main()