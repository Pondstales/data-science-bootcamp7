# get request
from requests import get
from time import sleep

nums = list(range(1,11))

result = []

for i in nums:
    url = f"https://api.tvmaze.com/shows/{i}"
    response = get(url)
    data = response.json()
    row = [
        data["name"],
        data["genres"],
        data["language"],
        data["premiered"],
        data["ended"]
    ]
    result.append(row)
    sleep(1)

print(result)

# write dataframe
import pandas as pd

df = pd.DataFrame(result, columns=["name", "genres", "language", "premiered", "ended"])

df

# save as a csv file
df.to_csv("tvmazeapi.csv")
