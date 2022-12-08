from cProfile import label
from math import gamma
from matplotlib import pyplot as plt  
import math       
import numpy as np


t = 0 
t_ls = [0]
chip1_ls = [0]
chip2_ls = [0]
chip_ls = [0]


# A only for chip 1 and B only for chip 2
lam = 0.002
n = 100
count_package = 0
proc_A_r = 0.9
proc_B_r = 2.8

A_q = [0, 1, 20, 30]
B_q = [10, 11, 21, 31]


def get_x(index):
    return math.floor(index/10)

def get_y(index):
    return index%10

def get_index(x, y):
    return x*10 + y

tau_table = np.array([[0, 0],
                    [0, 0],
                    [0, 0],
                    [0, 0]])
    

while count_package < n:
    is_arrival = True
    u1 = np.random.uniform()
    u2 = np.random.uniform()
    tau1 = -math.log(1-u1)*(1/(lam*n*0.2))
    tau2 = -math.log(1-u2)*(1/(lam*n*0.8))

    tau_proc_min = math.inf
    i_min = -1
    j_min = -1
    machine_type = -1

    for i in range(4):
        for j in range(2):
            if tau_table[i][j] == 0:
                continue
            else:
                u_proc = np.random.uniform()
                my_index = get_index(i, j)
                tau_proc = 0
                if my_index in (0, 1, 20, 30):
                    tau_proc = -math.log(1-u_proc)*(1/(proc_A_r))
                else:
                    tau_proc = -math.log(1-u_proc)*(1/(proc_B_r))
            if tau_proc < tau_proc_min:
                tau_proc_min = tau_proc
                i_min = i
                j_min = j
                if my_index in (0, 1, 20, 30):
                    machine_type = 1
                else:
                    machine_type = 2

    if tau_proc_min < min(tau1, tau2):
        is_arrival = False

    if is_arrival:
        count_package += 1
        if tau1 < tau2:
            t_ls.append(t_ls[-1] + tau1)
            chip_ls.append(chip_ls[-1] + 1)
            chip1_ls.append(chip1_ls[-1] + 1)
            chip2_ls.append(chip2_ls[-1])
            if (len(A_q) == 0):
                print("new chip 1 package arrival, waiting for free machine ...")
            else:
                machine_index = A_q.pop(0)
                x = get_x(machine_index)
                y = get_y(machine_index)
                print("new chip 1 package arrival and being processed by company {} machine {}".format(x, y))
                tau_table[x][y] = proc_A_r
        else:
            t_ls.append(t_ls[-1] + tau2)
            chip_ls.append(chip_ls[-1] + 1)
            chip2_ls.append(chip2_ls[-1] + 1)
            chip1_ls.append(chip1_ls[-1])
            if (len(B_q) == 0):
                print("new chip 2 package arrival, waiting for free machine ...")
            else:
                machine_index = B_q.pop(0)
                x = get_x(machine_index)
                y = get_y(machine_index)
                print("one chip 2 package being processed by company {} machine {}".format(x, y))
                tau_table[x][y] = proc_B_r

    if not is_arrival:
        t_ls.append(t_ls[-1] + tau_proc_min)
        machine_index = get_index(i_min, j_min)
        if machine_type == 1:
            print("machine {} in company {} finishes chip 1".format(j_min, i_min))
            A_q.append(machine_index)
            tau_table[i_min][j_min] = 0

            chip_ls.append(chip_ls[-1] - 1)
            chip1_ls.append(chip1_ls[-1] - 1)
            chip2_ls.append(chip2_ls[-1])

            if chip1_ls[-1] > 0:
                machine_index = A_q.pop(0)
                x = get_x(machine_index)
                y = get_y(machine_index)
                print("one chip 1 package being processed by company {} machine {}".format(x, y))
                tau_table[x][y] = proc_A_r
        else:
            print("machine {} in company {} finishes chip 2".format(j_min, i_min))
            B_q.append(machine_index)
            tau_table[i_min][j_min] = 0

            chip_ls.append(chip_ls[-1] - 1)
            chip1_ls.append(chip1_ls[-1])
            chip2_ls.append(chip2_ls[-1] - 1)

            if chip2_ls[-1] > 0:
                machine_index = B_q.pop(0)
                x = get_x(machine_index)
                y = get_y(machine_index)
                print("one chip 2 package being processed by company {} machine {}".format(x, y))
                tau_table[x][y] = proc_A_r
                

fig, ax = plt.subplots()
ax.plot(t_ls, chip1_ls, label = 'chip 1 package')
ax.plot(t_ls, chip2_ls, label = 'chip 2 package')
ax.plot(t_ls, chip_ls, label = 'total chip package')          
ax.legend()

plt.show()










