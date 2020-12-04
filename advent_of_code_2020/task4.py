
with open('task4_0.txt', 'r') as f:
    input = ''.join(f.readlines())

input = input.split('\n\n')
input = [i.replace('\n', ' ').split(' ') for i in input]

def split(x):
    key, val = x.split(':')
    return key, val

passports = [dict([split(j) for j in i if ':' in j]) for i in input]
print('Examples', passports[:3])

# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID) part 1 - don't look at it 

REQ = ['byr', 'iyr', 'eyr', 'hgt','hcl', 'ecl', 'pid']

# Part I
# def is_valid(passport: dict):
#     return sum([key in passport for key in REQ]) == len(REQ)

# Part II

# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
#     If cm, the number must be at least 150 and at most 193.
#     If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.
def is_valid(passport: dict):
    if sum([key in passport for key in REQ]) != len(REQ):
        return False

    def date_valid(date, r=(1920, 2002)):
        return r[0] <= int(date) <= r[1]

    def height_valid(height):
        m = height[-2:]
        n = height[:-2]
        if not n.isnumeric(): 
            return False

        n = int(n)
        if m == 'cm':
            return 150 <= n <= 193
        elif m == 'in':
            return 59 <= n <= 76
        else:
            return False

    def color_valid(color):
        if color[0] != '#' or len(color[1:]) != 6:
            return False
        
        CODE = '0123456789abcdef'
        return bool(min([i in CODE for i in color[1:]]))
        
    def eye_color(eye):
        CLRS = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']
        return eye in CLRS

    def pid_valid(pid):
        return pid.isnumeric() and len(pid) == 9

    return date_valid(passport['byr']) \
        and date_valid(passport['iyr'], r=(2010, 2020)) \
            and date_valid(passport['eyr'], r=(2020, 2030)) \
                and height_valid(passport['hgt']) \
                    and color_valid(passport['hcl']) \
                        and eye_color(passport['ecl']) \
                            and pid_valid(passport['pid'])
    


print("Valid passports:", len([p for p in passports if is_valid(p)]), "from total", len(passports))