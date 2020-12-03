with open('task3_0.txt') as f:
    lines = f.readlines()
    lines = [line.replace('\n', '') for line in lines]
    carte = [[0 if ch == '.' else 1 for ch in line] for line in lines]

# for row in carte:
#     print(row)

def tree_bumper(topology, step=(1, 3)):
    counter = 0
    row = 0
    col = 0
    print(f"path {step}")
    for _ in range(len(topology)):
        if row >= len(topology):
            continue
        pos = topology[row][col % len(topology[row])]
        counter += (pos == 1)
        row += step[0]
        col += step[1]

    return counter


# Right 1, down 1.
l1 = tree_bumper(carte, step=(1, 1))
# Right 3, down 1.
l2 = tree_bumper(carte, step=(1, 3))
# Right 5, down 1.
l3 = tree_bumper(carte, step=(1, 5))
# Right 7, down 1.
l4 = tree_bumper(carte, step=(1, 7))
# Right 1, down 2.
l5 = tree_bumper(carte, step=(2, 1))

print(l1 * l2 * l3 * l4 * l5)
