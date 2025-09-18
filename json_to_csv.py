import json
import csv

with open("result.json", "r") as f:
    data = json.load(f)

tests = []

# In legacy JSON, test results are usually under 'actions' -> '_values' -> 'actionResult' -> 'tests'
for action in data.get("actions", {}).get("_values", []):
    action_result = action.get("actionResult", {})
    test_summaries = action_result.get("tests", {}).get("_values", [])
    for test in test_summaries:
        test_name = test.get("identifier", "")
        test_status = test.get("testStatus", "")
        duration = test.get("duration", 0)
        tests.append({
            "test_name": test_name,
            "status": test_status,
            "duration": duration
        })

# Write CSV
with open("result.csv", "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["test_name", "status", "duration"])
    writer.writeheader()
    for t in tests:
        writer.writerow(t)

print("CSV saved as result.csv")
