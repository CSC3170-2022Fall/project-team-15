from cProfile import label
from math import gamma
from matplotlib import pyplot as plt  
import math       
import numpy


t = 0 
t_ls = [0]
chip1_ls = [0]
chip2_ls = [0]
chip_ls = [0]

chip1_r = 0.2
chip2_r = 0.8
lam = 0.002
n = 1000

for i in range(100):
    u = numpy.random.uniform()
    tau = -math.log(1-u)*(1/(lam*n))
    u_flag = numpy.random.uniform()
    if u_flag < chip1_r:
        chip1_ls.append(chip1_ls[-1]+1)
        chip2_ls.append(chip2_ls[-1])
    else:
        chip2_ls.append(chip2_ls[-1]+1)
        chip1_ls.append(chip1_ls[-1])
    chip_ls.append(chip_ls[-1] + 1)
    t_ls.append(t_ls[-1] + tau)


fig, ax = plt.subplots()
ax.plot(t_ls, chip1_ls, label = 'chip 1 package')
ax.plot(t_ls, chip2_ls, label = 'chip 2 package')
ax.plot(t_ls, chip_ls, label = 'total chip package')
ax.legend()

plt.show()

