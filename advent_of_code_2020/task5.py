MAX_ROWS = 128
MAX_COLS = 8

def get_place(code):
    if len(code) != 10:
        return None

    def get(vals, high=MAX_ROWS, c=('F', 'B')):
        forward, backward = c
        low = 0
        for v in vals:
            if v == forward:
                high -= (high - low) // 2
            if v == backward:
                low += (high - low) // 2

        return min(low, high)


    return get(code[:7]), get(code[7:], high=8, c=('L', 'R'))

def get_id(place):
    return place[0] * 8 + place[1]

# print(get_id('BBFFBBFRLL'))

with open('task5_0.txt') as f:
    codes = [line.replace('\n', '') for line in f.readlines()]

# Part 1
results = [get_id(get_place(c)) for c in codes]
print(max(results))

# Part II
def draw_plane(places, dim=(MAX_ROWS, MAX_COLS)):
    import numpy as np
    plane = np.zeros(dim)
    for p in places:
        plane[p[0]][p[1]] = 1
    
    for i in range(dim[0]):
        print(plane[i])
        if sum(plane[i]) == dim[1] - 1:
            id = get_id((i, np.argmin(plane[i])))

    return id

places = [get_place(c) for c in codes]
empty_spot = draw_plane(places)
print("Found the spot with ID", empty_spot)