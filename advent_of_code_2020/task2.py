

class Password:

    def __init__(self, line):
        comps = line.split(' ')
        r = comps[0].split('-')
        self.start = int(r[0])
        self.end = int(r[1])
        self.letter = comps[1][0]  # remove `:`
        self.password = comps[2]

    def __str__(self):
        return f"Password {self.password} must contain {self.letter} in range {self.start}..{self.end}"

    # part I
    # def is_valid(self):
    #     count = len(self.password) - len(self.password.replace(self.letter, ''))
    #     return self.start <= count <= self.end

    # part II
    def is_valid(self):
        if self.password[self.start - 1] == self.password[self.end - 1] == self.letter:
            return False
        
        if self.password[self.start - 1] == self.letter or self.password[self.end - 1] == self.letter:
            return True
        
        return False


with open('task2_0.txt') as f:
    passwords = [Password(i.replace('\n', '')) for i in f.readlines()]


print('Test pass', passwords[0], 'Valid', passwords[0].is_valid())

print('Total valid passwords', len([p for p in passwords if p.is_valid()]))