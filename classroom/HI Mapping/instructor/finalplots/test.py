listoflists = []
a_list = []
for i in range(0,10):
    a_list.append(i)
    if len(a_list)>3:
        a_list.remove(a_list[0])
        listoflists.append((list(a_list), a_list[0]))
print listoflists