from datetime import date

def days_until(target_date):
    today = date.today()
    remaining = (target_date - today).days
    return remaining

target = date(2025, 12, 31)  # Example: countdown to end of 2025
print(f"{days_until(target)} days remaining")

