import itertools

combinations = itertools.product(*itertools.repeat(['A','T','C','G'], 14))

for i in combinations:
    kmers = (''.join(i))
    print(">"+''.join(i), "\n", kmers)
