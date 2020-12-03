import requests

with open('task1_0.txt') as f:
    lines = [line.replace('\n', '') for line in f.readlines()]
    input = [int(i) for i in lines]

for i in range(len(input)):
    for j in range(len(input)):
        if i == j:
            continue

        if input[i] + input[j] == 2020:
            print(f"Found {input[i]} & {input[j]} = {input[i] * input[j]}")

        for k in range(len(input)):
            if i == k == j:
                continue

            if input[i] + input[j] + input[k] == 2020:
                print(f"Found {input[i]} & {input[j]} & {input[k]} = {input[i] * input[j] * input[k]}")
