import pandas as pd

def load_csv(file_path):
    try:
        df = pd.read_csv(file_path)
        return df
    except FileNotFoundError:
        print(f"File '{file_path}' not found")
        return None
    except Exception as e:
        print(f"Error loading CSV file: {e}")
        return None

def process_data(df):
    pass

def main():
    csv_path = 'data/alerts.csv'
    df = load_csv(csv_path)
    if df is None:
        return
    process_data(df)


if __name__ == '__main__':
    main()