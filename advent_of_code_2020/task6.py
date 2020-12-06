with open('task6_0.txt', 'r') as f:
    input = ''.join(f.readlines())

# Test vals
# input = '''abc

# a
# b
# c

# ab
# ac

# a
# a
# a
# a

# b'''

input = input.split('\n\n')
input = [i.replace('\n', ' ').split(' ') for i in input]

# Part I
# for group in input:
#     for a in group:
#         per_group.append({l for l in a})
# sum([len(i) for i in per_group])

# Part II
[[a for a in group] for group in input]

ex = [set(i) for i in input[0]]
print(ex)
print(ex[0].intersection(*ex[1:]))

to_set = [[set(l) for l in i] for i in input]
common = [s[0].intersection(*s[1:]) for s in to_set]
len_per_entry = [len(entry) for entry in common]
print(len_per_entry)
print('Common', sum(len_per_entry))